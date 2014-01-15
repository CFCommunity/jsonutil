<cfcomponent extends="mxunit.framework.TestCase">
	
	<cffunction name="setUp" output="false" access="public" returntype="void" hint="">		
		<cfset variables.JSONUtil = CreateObject("component","jsonutil.JSONUtil") />
	</cffunction>
	
	<cffunction name="tearDown" output="false" access="public" returntype="void" hint="">
		
	</cffunction>
	
	<cffunction name="testArray" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a simple array.">
		<cfset testValue = ['hello','world'] />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBinary" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for binary data.">
		<cftry>
			<cfset testValue = CharsetDecode("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Mauris id enim. Maecenas venenatis, mauris at vehicula viverra, augue purus rutrum sem, vitae pellentesque justo justo sit amet leo. Cras viverra turpis et sapien auctor faucibus. Nam pharetra turpis quis enim. Nam bibendum placerat nulla. Praesent suscipit, lorem et venenatis pellentesque, quam risus consectetuer dolor, eget placerat elit massa quis turpis. Praesent venenatis dolor eu felis. Duis sed nulla. Nulla eleifend, purus eu tincidunt sodales, orci augue vestibulum libero, feugiat semper tellus ipsum eu velit. Morbi nulla mauris, lacinia pulvinar, imperdiet sit amet, condimentum vitae, ligula. Nulla vehicula luctus felis. Quisque tincidunt. Mauris pede tortor, congue in, placerat et, scelerisque ac, justo. Quisque sollicitudin augue eu libero. Cras dictum nisi auctor massa. Nunc neque felis, accumsan convallis, fringilla et, congue in, lorem. Nam faucibus pede eu orci. Nullam vitae nulla. Ut vel tortor. Vestibulum pede. Morbi bibendum volutpat.","utf-8")  />
			<cfset testJSON = SerializeJSON(testValue) />
			<cfset debug(testJSON)>
			<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
			<cfset CF8CF = DeserializeJSON(testJSON) />
			<cfset assertEquals(JSONUtilCF,CF8CF) />
			<cfcatch type="Application">
				<cfset assertEquals(cfcatch.message,"JSON serialization failure: Unable to serialize binary data to JSON.") />
			</cfcatch>		
		</cftry>		
	</cffunction>
	
	<cffunction name="testBooleanTrueBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a boolean true.">
		<cfset testValue =  true />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBooleanFalseBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a boolean false.">
		<cfset testValue =  false />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBoolean1" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the number 1.">
		<cfset testValue =  1 />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBoolean0" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the number 0.">
		<cfset testValue =  0 />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBooleanYes" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the string 'Yes'.">
		<cfset testValue =  "Yes" />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBooleanNo" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the string 'No'.">
		<cfset testValue =  "No" />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBooleanTrue" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the string 'True'.">
		<cfset testValue = "True" />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testBooleanFalse" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for the string 'False'.">
		<cfset testValue = "False" />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<!---
	<cffunction name="testCustomFunction" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a UDF.">
		<cfset testJSON = SerializeJSON(functionToSerialize) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />		
	</cffunction>
	--->
	
	<cffunction name="testDate" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a date.">
		<cfset testValue = Now()  />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testNumericInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a number.">
		<cfset testValue = 123  />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testNumericDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a number.">
		<cfset testValue = 123.456  />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<!---
	<cffunction name="testObjectComponent" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion component.">
		<cfset testValue = CreateObject("component","TestComponent")  />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	--->
	
	<cffunction name="testObjectJava" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a Java object.">
		<cfset testValue = CreateObject("java","java.lang.String")  />
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testQuery" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("VarCharCol,IntCol,DecimalCol,DateCol","VarChar,Integer,Decimal,Date") />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","Test String") />
		<cfset QuerySetCell(testValue,"IntCol",1) />
		<cfset QuerySetCell(testValue,"DecimalCol",1.1) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","123") />
		<cfset QuerySetCell(testValue,"IntCol",2) />
		<cfset QuerySetCell(testValue,"DecimalCol",2.2) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","true") />
		<cfset QuerySetCell(testValue,"IntCol",3) />
		<cfset QuerySetCell(testValue,"DecimalCol",3.3) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />		
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset debug(JSONUtilCF)>
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset debug(CF8CF)>
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testQueryByColumns" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("VarCharCol,IntCol,DecimalCol,DateCol","VarChar,Integer,Decimal,Date") />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","Test String") />
		<cfset QuerySetCell(testValue,"IntCol",1) />
		<cfset QuerySetCell(testValue,"DecimalCol",1.1) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","123") />
		<cfset QuerySetCell(testValue,"IntCol",2) />
		<cfset QuerySetCell(testValue,"DecimalCol",2.2) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","true") />
		<cfset QuerySetCell(testValue,"IntCol",3) />
		<cfset QuerySetCell(testValue,"DecimalCol",3.3) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />			
		<cfset testJSON = SerializeJSON(testValue, true) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset debug(JSONUtilCF)>
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset debug(CF8CF)>
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testQueryNotStrict" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("VarCharCol,IntCol,DecimalCol,DateCol","VarChar,Integer,Decimal,Date") />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","Test String") />
		<cfset QuerySetCell(testValue,"IntCol",1) />
		<cfset QuerySetCell(testValue,"DecimalCol",1.1) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","123") />
		<cfset QuerySetCell(testValue,"IntCol",2) />
		<cfset QuerySetCell(testValue,"DecimalCol",2.2) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","true") />
		<cfset QuerySetCell(testValue,"IntCol",3) />
		<cfset QuerySetCell(testValue,"DecimalCol",3.3) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />			
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON, false) />
		<cfset debug(JSONUtilCF)>
		<cfset CF8CF = DeserializeJSON(testJSON, false) />
		<cfset debug(CF8CF)>
		
		<!--- conver to WDDX to compare --->
		<cfwddx action="cfml2wddx" input="#JSONUtilCF#" output="JSONUtilWDDX"/>
		<cfwddx action="cfml2wddx" input="#CF8CF#" output="CF8WDDX"/>
		
		<cfset assertTrue(CompareNoCase(JSONUtilWDDX,CF8WDDX)) />
		
	</cffunction>
	
	<cffunction name="testQueryByColumnsNotStrict" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("VarCharCol,IntCol,DecimalCol,DateCol","VarChar,Integer,Decimal,Date") />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","Test String") />
		<cfset QuerySetCell(testValue,"IntCol",1) />
		<cfset QuerySetCell(testValue,"DecimalCol",1.1) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","123") />
		<cfset QuerySetCell(testValue,"IntCol",2) />
		<cfset QuerySetCell(testValue,"DecimalCol",2.2) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />
		<cfset QueryAddRow(testValue) />
		<cfset QuerySetCell(testValue,"VarCharCol","true") />
		<cfset QuerySetCell(testValue,"IntCol",3) />
		<cfset QuerySetCell(testValue,"DecimalCol",3.3) />
		<cfset QuerySetCell(testValue,"DateCol",CreateDateTime(2008, 12, 14, 14, 30, 0)) />			
		<cfset testJSON = SerializeJSON(testValue, true) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON, false) />
		<cfset debug(JSONUtilCF)>
		<cfset CF8CF = DeserializeJSON(testJSON, false) />
		<cfset debug(CF8CF)>
				
		<!--- conver to WDDX to compare --->
		<cfwddx action="cfml2wddx" input="#JSONUtilCF#" output="JSONUtilWDDX"/>
		<cfwddx action="cfml2wddx" input="#CF8CF#" output="CF8WDDX"/>
		
		<cfset assertTrue(CompareNoCase(JSONUtilWDDX,CF8WDDX)) />
			
	</cffunction>
	
	<cffunction name="testQueryNotStrictWithBracket" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("Remarks,Name")>
		<cfset QueryAddRow(testValue)>
		<cfset QuerySetCell(testValue,"Remarks","Brackets test [68] to see if it deserializes")>
		<cfset QuerySetCell(testValue,"Name","TEST")>			
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON, false) />
		<cfset debug(JSONUtilCF)>
				
		<cfset assertTrue(IsQuery(JSONUtilCF)) />
		
	</cffunction>
	
	<cffunction name="testQueryByColumnsNotStrictWithBracket" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion query.">
		<cfset testValue = QueryNew("Remarks,Name")>
		<cfset QueryAddRow(testValue)>
		<cfset QuerySetCell(testValue,"Remarks","Brackets test [68] to see if it deserializes")>
		<cfset QuerySetCell(testValue,"Name","TEST")>				
		<cfset testJSON = SerializeJSON(testValue, true) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON, false) />
		<cfset debug(JSONUtilCF)>
						
		<cfset assertTrue(IsQuery(JSONUtilCF)) />
		
	</cffunction>	
	
	<cffunction name="testString" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a string.">
		<cfset testValue = "Hello World!" />	
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testStruct" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a ColdFusion structure.">
		<cfset testValue = {keyone="item one", keytwo="item two", keythree="item three"} />	
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testWDDX" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for a WDDX serialized array.">
		<cfset testVarWDDX = ["item one","item two","item three"] />
		<cfwddx action="cfml2wddx" input="#testVarWDDX#" output="testValue" />	
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	<cffunction name="testXML" output="false" access="public" returntype="void" hint="Compare JSONUtil.deserialize to DeserializeJSON for an XML document.">

<cfxml variable="testValue">
<users>
	<user id="1" active="false">
		<name>Nathan</name>
	</user>
	<user id="2" active="true">
		<name>Barbara</name>
	</user>
</users>
</cfxml>	
		<cfset testJSON = SerializeJSON(testValue) />
		<cfset debug(testJSON)>
		<cfset JSONUtilCF = variables.JSONUtil.deserialize(testJSON) />
		<cfset CF8CF = DeserializeJSON(testJSON) />
		<cfset assertEquals(JSONUtilCF,CF8CF) />
	</cffunction>
	
	
	<cffunction name="functionToSerialize" returntype="string" roles="someRole" access="private" description="This is a test description" output="false" displayname="TestFunction" hint="This is a hint">
	
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="messagePrefix" type="string" required="false" default=""/>	
		<cfreturn arguments.messagePrefix & " " & arguments.message />
		
	</cffunction>

	
</cfcomponent>