<cfcomponent extends="mxunit.framework.TestCase">
	
	<cffunction name="setUp" output="false" access="public" returntype="void" hint="">		
		<cfset variables.JSONUtil = CreateObject("component","jsonutil.JSONUtil") />
	</cffunction>
	
	<cffunction name="tearDown" output="false" access="public" returntype="void" hint="">
		
	</cffunction>
	
	<cffunction name="testBooleanTrueBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a boolean true.">
		<cfset testValue =  true />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "true" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalseBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a boolean false.">
		<cfset testValue =  false />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "false" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBoolean1" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 1.">
		<cfset testValue =  1 />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "true" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBoolean0" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 0.">
		<cfset testValue =  0 />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "false" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>	
	
	<cffunction name="testBooleanYes" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'Yes'.">
		<cfset testValue =  "Yes" />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "true" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanNo" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'No'.">
		<cfset testValue =  "No" />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "false" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanTrue" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'True'.">
		<cfset testValue = "True" />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "true" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalse" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'False'.">
		<cfset testValue = "False" />
		<cfset testValue = JavaCast("boolean",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "false" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"123"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123.456  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"123.456"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
		
	<cffunction name="testNumericInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123  />
		<cfset testValue = JavaCast("int",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "123" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testNumericDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123.456  />
		<cfset testValue = JavaCast("double",testValue) />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = "123.456" />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
		
	<cffunction name="testStringInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123"  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"123"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testStringDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123.456" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"123.456"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testQuery" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion query.">
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
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '{"COLUMNS":["VARCHARCOL","INTCOL","DECIMALCOL","DATECOL"],"DATA":[["Test String",1,1.1,"December, 14 2008 14:30:00"],["123",2,2.2,"December, 14 2008 14:30:00"],["true",3,3.3,"December, 14 2008 14:30:00"]]}' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testQueryByColumns" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion query.">
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
		<cfset testJSON = variables.JSONUtil.serialize(testValue, true, true) />
		<cfset referenceJSON = '{"ROWCOUNT":3,"COLUMNS":["VARCHARCOL","INTCOL","DECIMALCOL","DATECOL"],"DATA":{"VARCHARCOL":["Test String","123","true"],"INTCOL":[1,2,3],"DECIMALCOL":[1.1,2.2,3.3],"DATECOL":["December, 14 2008 14:30:00","December, 14 2008 14:30:00","December, 14 2008 14:30:00"]}}' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testString" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a string.">
		<cfset testValue = "Hello World!" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"Hello World!"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testStringBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a string.">
		<cfset testValue = "false" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"false"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testStringNumeric" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a string.">
		<cfset testValue = "123" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue, false, true) />
		<cfset referenceJSON = '"123"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
</cfcomponent>