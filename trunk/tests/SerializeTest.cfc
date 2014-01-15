<cfcomponent extends="mxunit.framework.TestCase">
	
	<cffunction name="setUp" output="false" access="public" returntype="void" hint="">		
		<cfset variables.JSONUtil = CreateObject("component","jsonutil.JSONUtil") />
	</cffunction>
	
	<cffunction name="tearDown" output="false" access="public" returntype="void" hint="">
		
	</cffunction>
	
	<cffunction name="testArray" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a simple array.">
		<cfset testValue = ['hello','world'] />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '["hello","world"]' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
		
	<cffunction name="testBinary" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for binary data.">
		<cfset testValue = CharsetDecode("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Mauris id enim. Maecenas venenatis, mauris at vehicula viverra, augue purus rutrum sem, vitae pellentesque justo justo sit amet leo. Cras viverra turpis et sapien auctor faucibus. Nam pharetra turpis quis enim. Nam bibendum placerat nulla. Praesent suscipit, lorem et venenatis pellentesque, quam risus consectetuer dolor, eget placerat elit massa quis turpis. Praesent venenatis dolor eu felis. Duis sed nulla. Nulla eleifend, purus eu tincidunt sodales, orci augue vestibulum libero, feugiat semper tellus ipsum eu velit. Morbi nulla mauris, lacinia pulvinar, imperdiet sit amet, condimentum vitae, ligula. Nulla vehicula luctus felis. Quisque tincidunt. Mauris pede tortor, congue in, placerat et, scelerisque ac, justo. Quisque sollicitudin augue eu libero. Cras dictum nisi auctor massa. Nunc neque felis, accumsan convallis, fringilla et, congue in, lorem. Nam faucibus pede eu orci. Nullam vitae nulla. Ut vel tortor. Vestibulum pede. Morbi bibendum volutpat.","utf-8")  />
		<cftry>
			<cfset testJSON = variables.JSONUtil.serialize(testValue) />
			<cfcatch type="Application">
				<cfset testError = cfcatch />
			</cfcatch>
		</cftry>
		
		<cftry>
			<cfset cfJSON = SerializeJSON(testValue) />
			<cfcatch type="Application">
				<cfset cfError = cfcatch />
			</cfcatch>
		</cftry>
				
		<cfset assertEquals(testError.type,cfError.type) />
		<cfset assertEquals(testError.message,cfError.message) />
		
	</cffunction>
		
	<cffunction name="testBooleanTrueBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a boolean true.">
		<cfset testValue =  true />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'true' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalseBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a boolean false.">
		<cfset testValue =  false />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'false' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBoolean1" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 1.">
		<cfset testValue =  1 />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '1.0' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBoolean0" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 0.">
		<cfset testValue =  0 />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '0.0' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanYes" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'Yes'.">
		<cfset testValue =  "Yes" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'true' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanNo" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'No'.">
		<cfset testValue =  "No" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'false' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanTrue" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'True'.">
		<cfset testValue = "True" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'true' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalse" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'False'.">
		<cfset testValue = "False" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = 'false' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<!---
	<cffunction name="testCustomFunction" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a UDF.">
		<cfset testJSON = variables.JSONUtil.serialize(functionToSerialize) />
		<cfset cfJSON = SerializeJSON(functionToSerialize) />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	--->	
	
	<cffunction name="testDate" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a date.">
		<cfset testValue = CreateDateTime(2009,10,22,21,41,27)  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '"October, 22 2009 21:41:27"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testNumericInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '123.0' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testNumericDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123.456  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '123.456' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testNumericLeadingZero" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "000123"  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '123.0' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testStringInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123"  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '123.0' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testStringDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123.456" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '123.456' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<!---
	<cffunction name="testObjectComponent" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion component.">
		<cfset testValue = CreateObject("component","TestComponent")  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	
	<cffunction name="testObjectJava" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a Java object.">
		<cfset testValue = CreateObject("java","java.lang.String")  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	--->
	
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
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset debug(testJSON) />
		<cfset referenceJSON = '{"COLUMNS":["VARCHARCOL","INTCOL","DECIMALCOL","DATECOL"],"DATA":[["Test String",1,1.1,"December, 14 2008 14:30:00"],[123.0,2,2.2,"December, 14 2008 14:30:00"],[true,3,3.3,"December, 14 2008 14:30:00"]]}' />
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
		<cfset testJSON = variables.JSONUtil.serialize(testValue, true) />
		<cfset referenceJSON = '{"ROWCOUNT":3,"COLUMNS":["VARCHARCOL","INTCOL","DECIMALCOL","DATECOL"],"DATA":{"VARCHARCOL":["Test String",123.0,true],"INTCOL":[1,2,3],"DECIMALCOL":[1.1,2.2,3.3],"DATECOL":["December, 14 2008 14:30:00","December, 14 2008 14:30:00","December, 14 2008 14:30:00"]}}' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testString" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a string.">
		<cfset testValue = "Hello World!" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '"Hello World!"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>

	<cffunction name="testStringWithControlCharacter0003" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for binary data.">
		<cfset testValue = "MBA Reunion Weekend is May 16-18! Join your friends, classmates, and reignite your relationship with the Wharton School by registering today." />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '"MBA Reunion Weekend is May 16-18! Join your friends, classmates, and reignite \u0003your relationship with the Wharton School by registering today."' />
		<cfset assertEquals(referenceJSON,testJSON) />		
	</cffunction>

	<cffunction name="testStringWithControlCharacter0019" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for binary data.">
		<cfset testValue = "An Icy Journey Gave Pennâs Leah Davidson a Worldly Perspective" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '"An Icy Journey Gave Pennâ\u0019s Leah Davidson a Worldly Perspective"' />
		<cfset assertEquals(referenceJSON,testJSON) />		
	</cffunction>
	
	<cffunction name="testStruct" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion structure.">
		<cfset testValue = {keyone="item one", keytwo="item two", keythree="item three"} />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '{"KEYTWO":"item two","KEYONE":"item one","KEYTHREE":"item three"}' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testWDDX" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a WDDX serialized array.">
		<cfset testVarWDDX = ["item one","item two","item three"] />
		<cfwddx action="cfml2wddx" input="#testVarWDDX#" output="testValue" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfsavecontent variable="referenceJSON">"<wddxPacket version='1.0'><header\/><data><array length='3'><string>item one<\/string><string>item two<\/string><string>item three<\/string><\/array><\/data><\/wddxPacket>"</cfsavecontent>
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	
	<cffunction name="testXML" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for an XML document.">
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
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset referenceJSON = '"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<users>\n\t<user active=\"false\" id=\"1\">\n\t\t<name>Nathan<\/name>\n\t<\/user>\n\t<user active=\"true\" id=\"2\">\n\t\t<name>Barbara<\/name>\n\t<\/user>\n<\/users>"' />
		<cfset assertEquals(testJSON,referenceJSON) />
	</cffunction>
	

	<cffunction name="functionToSerialize" returntype="string" roles="someRole" access="private" description="This is a test description" output="false" displayname="TestFunction" hint="This is a hint">
	
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="messagePrefix" type="string" required="false" default=""/>	
		<cfreturn arguments.messagePrefix & " " & arguments.message />
		
	</cffunction>	
	
</cfcomponent>