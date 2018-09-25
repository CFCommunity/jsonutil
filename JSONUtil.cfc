<!---

Copyright 2009 Nathan Mische

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

--->
<cfcomponent displayname="JSONUtil" output="false">

	<cfset this.deserializeJSON = deserializeFromJSON>
	<cfset this.serializeJSON = serializeToJSON>

	<cfset this.deserialize = deserializeFromJSON>
	<cfset this.serialize = serializeToJSON>

	<cfset this.isLuceeRailo = structKeyExists(server, "lucee") or structKeyExists(server, "railo")>

	<cffunction name="init" output="false">
		<cfreturn this>
	</cffunction>

	<cffunction
		name="deserializeFromJSON"
		access="public"
		returntype="any"
		output="false"
		hint="Converts a JSON (JavaScript Object Notation) string data representation into CFML data, such as a CFML structure or array.">
		<cfargument
			name="JSONVar"
			type="string"
			required="true"
			hint="A string that contains a valid JSON construct, or variable that represents one.">
		<cfargument
			name="strictMapping"
			type="boolean"
			required="false"
			default="true"
			hint="A Boolean value that specifies whether to convert the JSON strictly, as follows:
				<ul>
					<li><code>true:</code> (Default) Convert the JSON string to ColdFusion data types that correspond directly to the JSON data types.</li>
					<li><code>false:</code> Determine if the JSON string contains representations of ColdFusion queries, and if so, convert them to queries.</li>
				</ul>">

		<!--- DECLARE VARIABLES --->
		<cfset var ar = arrayNew(1)>
		<cfset var st = structNew()>
		<cfset var dataType = "">
		<cfset var inQuotes = false>
		<cfset var startPos = 1>
		<cfset var nestingLevel = 0>
		<cfset var dataSize = 0>
		<cfset var i = 1>
		<cfset var skipIncrement = false>
		<cfset var j = 0>
		<cfset var char = "">
		<cfset var dataStr = "">
		<cfset var structVal = "">
		<cfset var structKey = "">
		<cfset var colonPos = "">
		<cfset var qRows = 0>
		<cfset var qCols = "">
		<cfset var qCol = "">
		<cfset var qData = "">
		<cfset var curCharIndex = "">
		<cfset var curChar = "">
		<cfset var result = "">
		<cfset var unescapeVals = "\\,\"",\/,\b,\t,\n,\f,\r">
		<cfset var unescapeToVals = "\,"",/,#chr(8)#,#chr(9)#,#chr(10)#,#chr(12)#,#chr(13)#">
		<cfset var unescapeVals2 = '\,",/,b,t,n,f,r'>
		<cfset var unescapetoVals2 = '\,",/,#chr(8)#,#chr(9)#,#chr(10)#,#chr(12)#,#chr(13)#'>
		<cfset var dJSONString = "">
		<cfset var pos = 0>

		<cfset var _data = trim(arguments.jsonVar)>

		<!--- NUMBER --->
		<cfif isNumeric(_data)>
			<cfreturn Val(_data)>

		<!--- NULL --->
		<cfelseif _data EQ "null">
			<cfreturn "null">

		<!--- BOOLEAN --->
		<cfelseif listFindNoCase("true,false", _data)>
			<cfreturn _data>

		<!--- EMPTY STRING --->
		<cfelseif _data EQ "''" OR _data EQ '""'>
			<cfreturn "">

		<!--- STRING --->
		<cfelseif reFind('^"[^\\"]*(?:\\.[^\\"]*)*"$', _data) EQ 1 OR reFind("^'[^\\']*(?:\\.[^\\']*)*'$", _data) EQ 1>
			<cfset _data = mid(_data, 2, len(_data)-2)>
			<!--- If there are any \b, \t, \n, \f, and \r, do extra processing
				(required because replaceList() won't work with those) --->
			<cfif find("\b", _data) OR find("\t", _data) OR find("\n", _data) OR find("\f", _data) OR find("\r", _data)>
				<cfset curCharIndex = 0>
				<cfset curChar = "">
				<cfset dJSONString = arrayNew(1)>
				<cfloop condition="true">
					<cfset curCharIndex = curCharIndex + 1>
					<cfif curCharIndex GT len(_data)>
						<cfbreak>
					<cfelse>
						<cfset curChar = mid(_data, curCharIndex, 1)>
						<cfif curChar EQ "\">
							<cfset curCharIndex = curCharIndex + 1>
							<cfset curChar = mid(_data, curCharIndex,1)>
							<cfset pos = listFind(unescapeVals2, curChar)>
							<cfif pos>
								<cfset arrayAppend(dJSONString,listGetAt(unescapetoVals2, pos))>
							<cfelse>
								<cfset arrayAppend(dJSONString,"\" & curChar)>
							</cfif>
						<cfelse>
							<cfset arrayAppend(dJSONString,curChar)>
						</cfif>
					</cfif>
				</cfloop>

				<cfreturn arrayToList(dJSONString,"")>
			<cfelse>
				<cfreturn replaceList(_data, unescapeVals, unescapeToVals)>
			</cfif>

		<!--- ARRAY, STRUCT, OR QUERY --->
		<cfelseif ( left(_data, 1) EQ "[" AND right(_data, 1) EQ "]" )
			OR ( left(_data, 1) EQ "{" AND right(_data, 1) EQ "}" )>

			<!--- Store the data type we're dealing with --->
			<cfif left(_data, 1) EQ "[" AND right(_data, 1) EQ "]">
				<cfset dataType = "array">
			<cfelseif reFindNoCase('^\{"ROWCOUNT":[0-9]+,"COLUMNS":\[("[^"]+",?)+\],"DATA":\{("[^"]+":\[.*\],?)+\}\}$', _data, 0) EQ 1 AND NOT arguments.strictMapping>
				<cfset dataType = "queryByColumns">
			<cfelseif reFindNoCase('^\{"COLUMNS":\[("[^"]+",?)+\],"DATA":\[(\[.*\],?)+\]\}$', _data, 0) EQ 1 AND NOT arguments.strictMapping>
				<cfset dataType = "query">
			<cfelse>
				<cfset dataType = "struct">
			</cfif>

			<!--- Remove the brackets --->
			<cfset _data = trim( mid(_data, 2, len(_data)-2) )>

			<!--- Deal with empty array/struct --->
			<cfif len(_data) EQ 0>
				<cfif dataType EQ "array">
					<cfreturn ar>
				<cfelse>
					<cfreturn st>
				</cfif>
			</cfif>

			<!--- Loop through the string characters --->
			<cfset dataSize = len(_data) + 1>
			<cfloop condition="#i# LTE #dataSize#">
				<cfset skipIncrement = false>
				<!--- Save current character --->
				<cfset char = mid(_data, i, 1)>

				<!--- If char is a quote, switch the quote status --->
				<cfif char EQ '"'>
					<cfset inQuotes = NOT inQuotes>
				<!--- If char is escape character, skip the next character --->
				<cfelseif char EQ "\" AND inQuotes>
					<cfset i = i + 2>
					<cfset skipIncrement = true>
				<!--- If char is a comma and is not in quotes, or if end of string, deal with data --->
				<cfelseif (char EQ "," AND NOT inQuotes AND nestingLevel EQ 0) OR i EQ len(_data)+1>
					<cfset dataStr = mid(_data, startPos, i-startPos)>

					<!--- If data type is array, append data to the array --->
					<cfif dataType EQ "array">
						<cfset arrayappend( ar, deserializeFromJSON(dataStr, arguments.strictMapping) )>
					<!--- If data type is struct or query or queryByColumns... --->
					<cfelseif dataType EQ "struct" OR dataType EQ "query" OR dataType EQ "queryByColumns">
						<cfset dataStr = mid(_data, startPos, i-startPos)>
						<cfset colonPos = find('":', dataStr)>
						<cfif colonPos>
							<cfset colonPos = colonPos + 1>
						<cfelse>
							<cfset colonPos = find(":", dataStr)>
						</cfif>
						<cfset structKey = trim( mid(dataStr, 1, colonPos-1) )>

						<!--- If needed, remove quotes from keys --->
						<cfif left(structKey, 1) EQ "'" OR left(structKey, 1) EQ '"'>
							<cfset structKey = mid( structKey, 2, len(structKey)-2 )>
						</cfif>

						<cfset structVal = mid( dataStr, colonPos+1, len(dataStr)-colonPos )>

						<!--- If struct, add to the structure --->
						<cfif dataType EQ "struct">
							<cfset structInsert( st, structKey, deserializeFromJSON(structVal, arguments.strictMapping) )>

						<!--- If query, build the query --->
						<cfelseif dataType EQ "queryByColumns">
							<cfif structKey EQ "rowcount">
								<cfset qRows = deserializeFromJSON(structVal, arguments.strictMapping)>
							<cfelseif structKey EQ "columns">
								<cfset qCols = deserializeFromJSON(structVal, arguments.strictMapping)>
								<cfset st = queryNew(arrayToList(qCols))>
								<cfif qRows>
									<cfset queryAddRow(st, qRows)>
								</cfif>
							<cfelseif structKey EQ "data">
								<cfset qData = deserializeFromJSON(structVal, arguments.strictMapping)>
								<cfset ar = structKeyArray(qData)>
								<cfloop from="1" to="#arrayLen(ar)#" index="j">
									<cfloop from="1" to="#st.recordcount#" index="qRows">
										<cfset qCol = ar[j]>
										<cfset querySetCell(st, qCol, qData[qCol][qRows], qRows)>
									</cfloop>
								</cfloop>
							</cfif>
						<cfelseif dataType EQ "query">
							<cfif structKey EQ "columns">
								<cfset qCols = deserializeFromJSON(structVal, arguments.strictMapping)>
								<cfset st = queryNew(arrayToList(qCols))>
							<cfelseif structKey EQ "data">
								<cfset qData = deserializeFromJSON(structVal, arguments.strictMapping)>
								<cfloop from="1" to="#arrayLen(qData)#" index="qRows">
									<cfset queryAddRow(st)>
									<cfloop from="1" to="#arrayLen(qCols)#" index="j">
										<cfset qCol = qCols[j]>
										<cfset querySetCell(st, qCol, qData[qRows][j], qRows)>
									</cfloop>
								</cfloop>
							</cfif>
						</cfif>
					</cfif>

					<cfset startPos = i + 1>
				<!--- If starting a new array or struct, add to nesting level --->
				<cfelseif "{[" CONTAINS char AND NOT inQuotes>
					<cfset nestingLevel = nestingLevel + 1>
				<!--- If ending an array or struct, subtract from nesting level --->
				<cfelseif "]}" CONTAINS char AND NOT inQuotes>
					<cfset nestingLevel = nestingLevel - 1>
				</cfif>

				<cfif NOT skipIncrement>
					<cfset i = i + 1>
				</cfif>
			</cfloop>

			<!--- Return appropriate value based on data type --->
			<cfif dataType EQ "array">
				<cfreturn ar>
			<cfelse>
				<cfreturn st>
			</cfif>

		<!--- INVALID JSON --->
		<cfelse>
			<cfthrow message="JSON parsing failure.">
		</cfif>
	</cffunction>

	<cffunction
		name="serializeToJSON"
		access="public"
		returntype="string"
		output="false"
		hint="Converts ColdFusion data into a JSON (JavaScript Object Notation) representation of the data.">
		<cfargument
			name="var"
			type="any"
			required="true"
			hint="A ColdFusion data value or variable that represents one.">
		<cfargument
			name="serializeQueryByColumns"
			type="boolean"
			required="false"
			default="false"
			hint="A Boolean value that specifies how to serialize ColdFusion queries.
				<ul>
					<li><code>false</code>: (Default) Creates an object with two entries: an array of column names and an array of row arrays. This format is required by the HTML format cfgrid tag.</li>
					<li><code>true</code>: Creates an object that corresponds to WDDX query format.</li>
				</ul>">
		<cfargument
			name="strictMapping"
			type="boolean"
			required="false"
			default="false"
			hint="A Boolean value that specifies whether to convert the ColdFusion data strictly, as follows:
				<ul>
					<li><code>false:</code> (Default) Convert the ColdFusion data to a JSON string using ColdFusion data types.</li>
					<li><code>true:</code> Convert the ColdFusion data to a JSON string using underlying Java/SQL data types.</li>
				</ul>">

		<!--- VARIABLE DECLARATION --->
		<cfset var jsonString = "">
		<cfset var tempVal = "">
		<cfset var arKeys = "">
		<cfset var colPos = 1>
		<cfset var md = "">
		<cfset var rowDel = "">
		<cfset var colDel = "">
		<cfset var className = "">
		<cfset var i = 1>
		<cfset var column = "">
		<cfset var datakey = "">
		<cfset var recordcountkey = "">
		<cfset var columnlist = "">
		<cfset var columnlistkey = "">
		<cfset var columnJavaTypes = "">
		<cfset var dJSONString = "">
		<cfset var escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r">
		<cfset var escapeVals = "\,"",/,#chr(8)#,#chr(9)#,#chr(10)#,#chr(12)#,#chr(13)#">

		<cfset var _data = arguments.var>

		<cfif arguments.strictMapping>
			<!--- GET THE CLASS NAME --->
			<cfset className = getClassName(_data)>
		</cfif>

		<!--- TRY STRICT MAPPING --->

		<cfif len(className) AND compareNoCase(className,"java.lang.String") eq 0>
			<cfreturn '"' & replaceList(_data, escapeVals, escapeToVals) & '"'>

		<cfelseif len(className) AND compareNoCase(className,"java.lang.Boolean") eq 0>
			<cfreturn replaceList(toString(_data), 'YES,NO', 'true,false')>

		<cfelseif len(className) AND compareNoCase(className,"java.lang.Integer") eq 0>
			<cfreturn toString(_data)>

		<cfelseif len(className) AND compareNoCase(className,"java.lang.Long") eq 0>
			<cfreturn toString(_data)>

		<cfelseif len(className) AND compareNoCase(className,"java.lang.Float") eq 0>
			<cfreturn toString(_data)>

		<cfelseif len(className) AND compareNoCase(className,"java.lang.Double") eq 0>
			<cfreturn toString(_data)>

		<!--- BINARY --->
		<cfelseif isBinary(_data)>
			<cfthrow message="JSON serialization failure: Unable to serialize binary data to JSON.">

		<!--- BOOLEAN --->
		<cfelseif isBoolean(_data) AND NOT isNumeric(_data)>
			<cfreturn replaceList(YesNoFormat(_data), 'Yes,No', 'true,false')>

		<!--- NUMBER --->
		<cfelseif isNumeric(_data)>
			<cfif getClassName(_data) eq "java.lang.String">
				<cfreturn Val(_data).toString()>
			<cfelse>
				<cfreturn _data.toString()>
			</cfif>

		<!--- DATE --->
		<cfelseif isDate(_data)>
			<cfreturn '"#dateFormat(_data, "mmmm, dd yyyy")# #timeFormat(_data, "HH:mm:ss")#"'>

		<!--- STRING --->
		<cfelseif isSimpleValue(_data)>
			<!---<cfreturn '"' & replaceList(_data, escapeVals, escapeToVals) & '"'>--->
			<cfreturn writeJsonUtf8String(_data)>

		<!--- RAILO XML --->
		<cfelseif this.isLuceeRailo and isXML(_data)>
			<cfreturn '"' & replaceList(toString(_data), escapeVals, escapeToVals) & '"'>

		<!--- CUSTOM FUNCTION --->
		<cfelseif isCustomFunction(_data)>
			<cfreturn serializeToJSON( getMetadata(_data), arguments.serializeQueryByColumns, arguments.strictMapping)>

		<!--- OBJECT --->
		<cfelseif isObject(_data)>
			<cfreturn "{}">

		<!--- ARRAY --->
		<cfelseif isArray(_data)>
			<cfset dJSONString = arrayNew(1)>
			<cfloop from="1" to="#arrayLen(_data)#" index="i">
				<cfset tempVal = serializeToJSON( _data[i], arguments.serializeQueryByColumns, arguments.strictMapping )>
				<cfset arrayAppend(dJSONString,tempVal)>
			</cfloop>

			<cfreturn "[" & arrayToList(dJSONString,",") & "]">

		<!--- STRUCT --->
		<cfelseif isStruct(_data)>
			<cfset dJSONString = arrayNew(1)>
			<cfset arKeys = structKeyArray(_data)>
			<cfloop from="1" to="#arrayLen(arKeys)#" index="i">
				<cfif isDefined("_data.#arKeys[i]#")>
					<cfset tempVal = serializeToJSON(_data[ arKeys[i] ], arguments.serializeQueryByColumns, arguments.strictMapping )>
				<cfelse>
					<cfset tempVal = "null">
				</cfif>
				<cfset arrayAppend(dJSONString,'"' & arKeys[i] & '":' & tempVal)>
			</cfloop>

			<cfreturn "{" & arrayToList(dJSONString,",") & "}">

		<!--- QUERY --->
		<cfelseif isQuery(_data)>
			<cfset dJSONString = arrayNew(1)>

			<!--- Add query meta data --->
			<cfset recordcountKey = "ROWCOUNT">
			<cfset columnlistKey = "COLUMNS">
			<cfset columnlist = "">
			<cfset dataKey = "DATA">
			<cfset md = getMetadata(_data)>
			<cfset columnJavaTypes = structNew()>
			<cfloop from="1" to="#arrayLen(md)#" index="column">
				<cfset columnlist = listAppend(columnlist,uCase(md[column].Name),',')>
				<cfif structKeyExists(md[column],"TypeName")>
					<cfset columnJavaTypes[md[column].Name] = getJavaType(md[column].TypeName)>
				<cfelse>
					<cfset columnJavaTypes[md[column].Name] = "">
				</cfif>
			</cfloop>

			<cfif arguments.serializeQueryByColumns>
				<cfset arrayAppend(dJSONString,'"#recordcountKey#":' & _data.recordcount)>
				<cfset arrayAppend(dJSONString,',"#columnlistKey#":[' & listQualify(columnlist, '"') & ']')>
				<cfset arrayAppend(dJSONString,',"#dataKey#":{')>
				<cfset colDel = "">
				<cfloop list="#columnlist#" delimiters="," index="column">
					<cfset arrayAppend(dJSONString,colDel)>
					<cfset arrayAppend(dJSONString,'"#column#":[')>
					<cfset rowDel = "">
					<cfloop from="1" to="#_data.recordcount#" index="i">
						<cfset arrayAppend(dJSONString,rowDel)>
						<cfif (arguments.strictMapping or this.isLuceeRailo) AND len(columnJavaTypes[column])>
							<cfset tempVal = serializeToJSON( javaCast(columnJavaTypes[column],_data[column][i]), arguments.serializeQueryByColumns, arguments.strictMapping )>
						<cfelse>
							<cfset tempVal = serializeToJSON( _data[column][i], arguments.serializeQueryByColumns, arguments.strictMapping )>
						</cfif>
						<cfset arrayAppend(dJSONString,tempVal)>
						<cfset rowDel = ",">
					</cfloop>
					<cfset arrayAppend(dJSONString,']')>
					<cfset colDel = ",">
				</cfloop>
				<cfset arrayAppend(dJSONString,'}')>
			<cfelse>
				<cfset arrayAppend(dJSONString,'"#columnlistKey#":[' & listQualify(columnlist, '"') & ']')>
				<cfset arrayAppend(dJSONString,',"#dataKey#":[')>
				<cfset rowDel = "">
				<cfloop from="1" to="#_data.recordcount#" index="i">
					<cfset arrayAppend(dJSONString,rowDel)>
					<cfset arrayAppend(dJSONString,'[')>
					<cfset colDel = "">
					<cfloop list="#columnlist#" delimiters="," index="column">
						<cfset arrayAppend(dJSONString,colDel)>
						<cfif (arguments.strictMapping or this.isLuceeRailo) AND len(columnJavaTypes[column])>
							<cfset tempVal = serializeToJSON( javaCast(columnJavaTypes[column],_data[column][i]), arguments.serializeQueryByColumns, arguments.strictMapping )>
						<cfelse>
							<cfset tempVal = serializeToJSON( _data[column][i], arguments.serializeQueryByColumns, arguments.strictMapping )>
						</cfif>
						<cfset arrayAppend(dJSONString,tempVal)>
						<cfset colDel=",">
					</cfloop>
					<cfset arrayAppend(dJSONString,']')>
					<cfset rowDel = ",">
				</cfloop>
				<cfset arrayAppend(dJSONString,']')>
			</cfif>

			<cfreturn "{" & arrayToList(dJSONString,"") & "}">

		<!--- XML --->
		<cfelseif isXML(_data)>
			<cfreturn '"' & replaceList(toString(_data), escapeVals, escapeToVals) & '"'>


		<!--- UNKNOWN OBJECT TYPE --->
		<cfelse>
			<cfreturn "{}">
		</cfif>

	</cffunction>

	<cffunction
		name="getJavaType"
		access="private"
		returntype="string"
		output="false"
		hint="Maps SQL to Java types. Returns blank string for unhandled SQL types.">
		<cfargument
			name="sqlType"
			type="string"
			required="true"
			hint="A SQL datatype.">

		<cfswitch expression="#arguments.sqlType#">

			<cfcase value="bit">
				<cfreturn "boolean">
			</cfcase>

			<cfcase value="tinyint,smallint,integer">
				<cfreturn "int">
			</cfcase>

			<cfcase value="bigint">
				<cfreturn "long">
			</cfcase>

			<cfcase value="real,float">
				<cfreturn "float">
			</cfcase>

			<cfcase value="double">
				<cfreturn "double">
			</cfcase>

			<cfcase value="char,varchar,longvarchar">
				<cfreturn "string">
			</cfcase>

			<cfdefaultcase>
				<cfreturn "">
			</cfdefaultcase>

		</cfswitch>

	</cffunction>

	<cffunction
		name="getClassName"
		access="private"
		returntype="string"
		output="false"
		hint="Returns a variable's underlying java Class name.">
		<cfargument
			name="data"
			type="any"
			required="true"
			hint="A variable.">

		<!--- GET THE CLASS NAME --->
		<cftry>
			<cfreturn arguments.data.getClass().getName()>
			<cfcatch type="any">
				<cfreturn "">
			</cfcatch>
		</cftry>

	</cffunction>

	<cffunction
		name="writeJsonUtf8String"
		access="private"
		returntype="string"
		output="false"
		hint="Returns a variable's underlying java Class name.">
		<cfargument
			name="data"
			type="string"
			required="true"
			hint="A string to serialze.">

		<!--- GET THE CLASS NAME --->
		<cfset var json = '"'>
		<cfset var end = len(data) - 1>
		<cfset var i = 0>
		<cfset var c = "">
		<cfset var integer = CreateObject("java","java.lang.Integer")>
		<cfset var pad = "">
		<cfset var hex = "">

		<cfloop from="0" to="#end#" index="i">
			<cfset c = data.charAt(i)>
			<cfif c lt ' '>
				<cfif c eq chr(8)>
					<cfset json = json & "\b">
				<cfelseif c eq chr(9)>
					<cfset json = json & "\t">
				<cfelseif c eq chr(10)>
					<cfset json = json & "\n">
				<cfelseif c eq chr(12)>
					<cfset json = json & "\f">
				<cfelseif c eq chr(13)>
					<cfset json = json & "\r">
				<cfelse>
					<cfset hex = integer.toHexString(c)>
					<cfset json = json & "\u">
					<cfset pad = 4 - len(hex)>
					<cfset json = json & repeatString("0", pad)>
					<cfset json = json & hex>
				</cfif>
			<cfelseif c eq '\' or c eq '/' or c eq '"'>
				<cfset json = json & "\" & c>
			<cfelse>
				<cfset json = json & c>
			</cfif>
		</cfloop>
		<cfset json = json & '"'>

		<cfreturn json>

	</cffunction>

</cfcomponent>
