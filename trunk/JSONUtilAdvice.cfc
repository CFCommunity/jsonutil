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
<cfcomponent output="false" displayname="JSONUtilAdvice" hint="I advise service layer methods and convert return format to JSON." extends="coldspring.aop.MethodInterceptor">

	<cffunction name="init" returntype="any" output="false" access="public" hint="Constructor">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="invokeMethod" returntype="any" access="public" output="false" hint="">
		<cfargument name="methodInvocation" type="coldspring.aop.MethodInvocation" required="true" hint="" />
		<cfset var methodResult =  arguments.methodInvocation.proceed() />
		
		<cfif (StructKeyExists(url,"strictjson") and url.strictjson)
		   or (StructKeyExists(form,"strictjson") and form.strictjson)>
			<cfreturn serializeToJSON(methodResult,false,true) />
		</cfif>
		
		<cfreturn methodResult />
		
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
			hint="A ColdFusion data value or variable that represents one." />
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
				</ul>" />
		
		<!--- VARIABLE DECLARATION --->
		<cfset var jsonString = "" />
		<cfset var tempVal = "" />
		<cfset var arKeys = "" />
		<cfset var colPos = 1 />
		<cfset var md = "" />
		<cfset var rowDel = "" />
		<cfset var colDel = "" />
		<cfset var className = "" />
		<cfset var i = 1 />
		<cfset var column = "" />
		<cfset var datakey = "" />
		<cfset var recordcountkey = "" />
		<cfset var columnlist = "" />
		<cfset var columnlistkey = "" />
		<cfset var columnJavaTypes = "" />
		<cfset var dJSONString = "" />
		<cfset var escapeToVals = "\\,\"",\/,\b,\t,\n,\f,\r" />
		<cfset var escapeVals = "\,"",/,#Chr(8)#,#Chr(9)#,#Chr(10)#,#Chr(12)#,#Chr(13)#" />
		
		<cfset var _data = arguments.var />
		
		<cfif arguments.strictMapping>		
			<!--- GET THE CLASS NAME --->			
			<cfset className = getClassName(_data) />							
		</cfif>
			
		<!--- TRY STRICT MAPPING --->
		
		<cfif Len(className) AND CompareNoCase(className,"java.lang.String") eq 0>
			<cfreturn '"' & ReplaceList(_data, escapeVals, escapeToVals) & '"' />
		
		<cfelseif Len(className) AND CompareNoCase(className,"java.lang.Boolean") eq 0>
			<cfreturn ReplaceList(ToString(_data), 'YES,NO', 'true,false') />
		
		<cfelseif Len(className) AND CompareNoCase(className,"java.lang.Integer") eq 0>
			<cfreturn ToString(_data) />
			
		<cfelseif Len(className) AND CompareNoCase(className,"java.lang.Long") eq 0>
			<cfreturn ToString(_data) />
			
		<cfelseif Len(className) AND CompareNoCase(className,"java.lang.Float") eq 0>
			<cfreturn ToString(_data) />
			
		<cfelseif Len(className) AND CompareNoCase(className,"java.lang.Double") eq 0>
			<cfreturn ToString(_data) />				
		
		<!--- BINARY --->
		<cfelseif IsBinary(_data)>
			<cfthrow message="JSON serialization failure: Unable to serialize binary data to JSON." />
		
		<!--- BOOLEAN --->
		<cfelseif IsBoolean(_data) AND NOT IsNumeric(_data)>
			<cfreturn ReplaceList(YesNoFormat(_data), 'Yes,No', 'true,false') />			
			
		<!--- NUMBER --->
		<cfelseif IsNumeric(_data)>
			<cfif getClassName(_data) eq "java.lang.String">
				<cfreturn Val(_data).toString() />
			<cfelse>
				<cfreturn _data.toString() />
			</cfif>
		
		<!--- DATE --->
		<cfelseif IsDate(_data)>
			<cfreturn '"#DateFormat(_data, "mmmm, dd yyyy")# #TimeFormat(_data, "HH:mm:ss")#"' />
		
		<!--- STRING --->
		<cfelseif IsSimpleValue(_data)>
			<cfreturn '"' & ReplaceList(_data, escapeVals, escapeToVals) & '"' />
			
		<!--- RAILO XML --->
		<cfelseif StructKeyExists(server,"railo") and IsXML(_data)>
			<cfreturn '"' & ReplaceList(ToString(_data), escapeVals, escapeToVals) & '"' />
		
		<!--- CUSTOM FUNCTION --->
		<cfelseif IsCustomFunction(_data)>			
			<cfreturn serializeToJSON( GetMetadata(_data), arguments.serializeQueryByColumns, arguments.strictMapping) />
			
		<!--- OBJECT --->
		<cfelseif IsObject(_data)>		
			<cfreturn "{}" />		
		
		<!--- ARRAY --->
		<cfelseif IsArray(_data)>
			<cfset dJSONString = ArrayNew(1) />
			<cfloop from="1" to="#ArrayLen(_data)#" index="i">
				<cfset tempVal = serializeToJSON( _data[i], arguments.serializeQueryByColumns, arguments.strictMapping ) />
				<cfset ArrayAppend(dJSONString,tempVal) />
			</cfloop>	
					
			<cfreturn "[" & ArrayToList(dJSONString,",") & "]" />
		
		<!--- STRUCT --->
		<cfelseif IsStruct(_data)>
			<cfset dJSONString = ArrayNew(1) />
			<cfset arKeys = StructKeyArray(_data) />
			<cfloop from="1" to="#ArrayLen(arKeys)#" index="i">
				<cfset tempVal = serializeToJSON(_data[ arKeys[i] ], arguments.serializeQueryByColumns, arguments.strictMapping ) />
				<cfset ArrayAppend(dJSONString,'"' & arKeys[i] & '":' & tempVal) />
			</cfloop>
						
			<cfreturn "{" & ArrayToList(dJSONString,",") & "}" />
		
		<!--- QUERY --->
		<cfelseif IsQuery(_data)>
			<cfset dJSONString = ArrayNew(1) />
			
			<!--- Add query meta data --->
			<cfset recordcountKey = "ROWCOUNT" />
			<cfset columnlistKey = "COLUMNS" />
			<cfset columnlist = "" />
			<cfset dataKey = "DATA" />
			<cfset md = GetMetadata(_data) />
			<cfset columnJavaTypes = StructNew() />					
			<cfloop from="1" to="#ArrayLen(md)#" index="column">
				<cfset columnlist = ListAppend(columnlist,UCase(md[column].Name),',') />
				<cfif StructKeyExists(md[column],"TypeName")>
					<cfset columnJavaTypes[md[column].Name] = getJavaType(md[column].TypeName) />
				<cfelse>
					<cfset columnJavaTypes[md[column].Name] = "" />
				</cfif>
			</cfloop>				
			
			<cfif arguments.serializeQueryByColumns>
				<cfset ArrayAppend(dJSONString,'"#recordcountKey#":' & _data.recordcount) />
				<cfset ArrayAppend(dJSONString,',"#columnlistKey#":[' & ListQualify(columnlist, '"') & ']') />
				<cfset ArrayAppend(dJSONString,',"#dataKey#":{') />
				<cfset colDel = "">
				<cfloop list="#columnlist#" delimiters="," index="column">
					<cfset ArrayAppend(dJSONString,colDel) />
					<cfset ArrayAppend(dJSONString,'"#column#":[') />
					<cfset rowDel = "">	
					<cfloop from="1" to="#_data.recordcount#" index="i">
						<cfset ArrayAppend(dJSONString,rowDel) />
						<cfif (arguments.strictMapping or StructKeyExists(server,"railo")) AND Len(columnJavaTypes[column])>
							<cfset tempVal = serializeToJSON( JavaCast(columnJavaTypes[column],_data[column][i]), arguments.serializeQueryByColumns, arguments.strictMapping ) />
						<cfelse>
							<cfset tempVal = serializeToJSON( _data[column][i], arguments.serializeQueryByColumns, arguments.strictMapping ) />
						</cfif>							
						<cfset ArrayAppend(dJSONString,tempVal) />
						<cfset rowDel = ",">	
					</cfloop>
					<cfset ArrayAppend(dJSONString,']') />
					<cfset colDel = ",">
				</cfloop>				
				<cfset ArrayAppend(dJSONString,'}') />			
			<cfelse>			
				<cfset ArrayAppend(dJSONString,'"#columnlistKey#":[' & ListQualify(columnlist, '"') & ']') />
				<cfset ArrayAppend(dJSONString,',"#dataKey#":[') />				
				<cfset rowDel = "">
				<cfloop from="1" to="#_data.recordcount#" index="i">
					<cfset ArrayAppend(dJSONString,rowDel) />
					<cfset ArrayAppend(dJSONString,'[') />
					<cfset colDel = "">					
					<cfloop list="#columnlist#" delimiters="," index="column">
						<cfset ArrayAppend(dJSONString,colDel) />
						<cfif (arguments.strictMapping or StructKeyExists(server,"railo")) AND Len(columnJavaTypes[column])>
							<cfset tempVal = serializeToJSON( JavaCast(columnJavaTypes[column],_data[column][i]), arguments.serializeQueryByColumns, arguments.strictMapping ) />
						<cfelse>
							<cfset tempVal = serializeToJSON( _data[column][i], arguments.serializeQueryByColumns, arguments.strictMapping ) />
						</cfif>	
						<cfset ArrayAppend(dJSONString,tempVal) />
						<cfset colDel=","/>
					</cfloop>					
					<cfset ArrayAppend(dJSONString,']') />
					<cfset rowDel = "," />
				</cfloop>				
				<cfset ArrayAppend(dJSONString,']') />			
			</cfif>
			
			<cfreturn "{" & ArrayToList(dJSONString,"") & "}">
			
		<!--- XML --->
		<cfelseif IsXML(_data)>
			<cfreturn '"' & ReplaceList(ToString(_data), escapeVals, escapeToVals) & '"' />
					
		
		<!--- UNKNOWN OBJECT TYPE --->
		<cfelse>
			<cfreturn "{}" />
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
			hint="A SQL datatype." />			
		
		<cfswitch expression="#arguments.sqlType#">
					
			<cfcase value="bit">
				<cfreturn "boolean" />
			</cfcase>
			
			<cfcase value="tinyint,smallint,integer">
				<cfreturn "int" />
			</cfcase>
			
			<cfcase value="bigint">
				<cfreturn "long" />
			</cfcase>
			
			<cfcase value="real,float">
				<cfreturn "float" />
			</cfcase>
			
			<cfcase value="double">
				<cfreturn "double" />
			</cfcase>
			
			<cfcase value="char,varchar,longvarchar">
				<cfreturn "string" />
			</cfcase>
			
			<cfdefaultcase>
				<cfreturn "" />
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
			hint="A variable." />
			
		<!--- GET THE CLASS NAME --->			
		<cftry>				
			<cfreturn arguments.data.getClass().getName() />			
			<cfcatch type="any">
				<cfreturn "" />
			</cfcatch>			
		</cftry>
		
	</cffunction>
	
</cfcomponent>