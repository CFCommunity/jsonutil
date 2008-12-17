<cfcomponent extends="mxunit.framework.TestCase">
	
	<cffunction name="setUp" output="false" access="public" returntype="void" hint="">		
		<cfset variables.JSONUtil = CreateObject("component","jsonutil.JSONUtil") />
	</cffunction>
	
	<cffunction name="tearDown" output="false" access="public" returntype="void" hint="">
		
	</cffunction>
	
	<cffunction name="testArray" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a simple array.">
		<cfset testValue = ['hello','world'] />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
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
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalseBoolean" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a boolean false.">
		<cfset testValue =  false />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBoolean1" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 1.">
		<cfset testValue =  1 />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBoolean0" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the number 0.">
		<cfset testValue =  0 />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBooleanYes" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'Yes'.">
		<cfset testValue =  "Yes" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBooleanNo" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'No'.">
		<cfset testValue =  "No" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBooleanTrue" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'True'.">
		<cfset testValue = "True" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testBooleanFalse" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for the string 'False'.">
		<cfset testValue = "False" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<!---
	<cffunction name="testCustomFunction" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a UDF.">
		<cfset testJSON = variables.JSONUtil.serialize(functionToSerialize) />
		<cfset cfJSON = SerializeJSON(functionToSerialize) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	--->	
	
	<cffunction name="testDate" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a date.">
		<cfset testValue = Now()  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testNumericInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testNumericDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = 123.456  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testStringInteger" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123"  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testStringDecimal" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a number.">
		<cfset testValue = "123.456" />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testObjectComponent" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion component.">
		<cfset testValue = CreateObject("component","TestComponent")  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<!---
	<cffunction name="testObjectJava" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a Java object.">
		<cfset testValue = CreateObject("java","java.lang.String")  />
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	--->
	
	<cffunction name="testQuery" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion query.">
		<cfquery name="testValue" datasource="cfartgallery">
			SELECT LastName, FirstName
			FROM   Artists
		</cfquery>		
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testQueryByColumns" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion query.">
		<cfquery name="testValue" datasource="cfartgallery">
			SELECT LastName, FirstName
			FROM   Artists
		</cfquery>			
		<cfset testJSON = variables.JSONUtil.serialize(testValue, true) />
		<cfset cfJSON = SerializeJSON(testValue, true) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testString" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a string.">
		<cfset testValue = "Hello World!" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testStruct" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a ColdFusion structure.">
		<cfset testValue = {keyone="item one", keytwo="item two", keythree="item three"} />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	
	<cffunction name="testWDDX" output="false" access="public" returntype="void" hint="Compare JSONUtil.serialize to SerializeJSON for a WDDX serialized array.">
		<cfset testVarWDDX = ["item one","item two","item three"] />
		<cfwddx action="cfml2wddx" input="#testVarWDDX#" output="testValue" />	
		<cfset testJSON = variables.JSONUtil.serialize(testValue) />
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
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
		<cfset cfJSON = SerializeJSON(testValue) />
		<cfset assertEquals(testJSON,cfJSON) />
	</cffunction>
	

	<cffunction name="functionToSerialize" returntype="string" roles="someRole" access="private" description="This is a test description" output="false" displayname="TestFunction" hint="This is a hint">
	
		<cfargument name="message" type="string" required="true"/>
		<cfargument name="messagePrefix" type="string" required="false" default=""/>	
		<cfreturn arguments.messagePrefix & " " & arguments.message />
		
	</cffunction>	
	
</cfcomponent>