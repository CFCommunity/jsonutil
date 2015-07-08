# JSONUtil

## Welcome

Welcome to JSONUtil, a ColdFusion component meant to to provide
ColdFusion 8 compatible JSON serialization and deserialization for
CFMX 7 and other CFML engines, as well as strict mapping of data types
for JSON serialization. For the latest releases and technical support
please go to the official JSONUtil site:

http://github.com/cfcommunity/jsonutil

## License and Credits

Copyright 2009 Nathan Mische and contributors

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.


## Contributors

JSONUtil was originally created by Nathan Mische <https://github.com/nmische>

Many people helped us create JSONUtil. This list is not complete, so please know that this was a
group effort and your feedback is always appreciated.

Thank you to the [CFJSON project](http://www.epiphantastic.com/cfjson). This project probably would not have happened were it not for CFJSON.
Thank you to Jehiah Czebotar, Thomas Messier, and everyone who has contributed to the CFJSON project.

If you like this project, please consider supporting the creators at their Amazon wish lists:

- [Nathan Mische](http://www.amazon.com/gp/registry/wishlist/1PMU5WXR9RZNJ/ref=wl_web/)

## Use

### Methods

The JSONUtil component has two main methods, deserializeJSON and
serializeJSON.

#### deserializeJSON:

Converts a JSON (JavaScript Object Notation) string data representation into CFML data, such as a CFML structure or array.

Arguments:

 - JSONVar: A string that contains a valid JSON construct, or variable that represents one.
 - strictMapping: A Boolean value that specifies whether to convert the JSON strictly, as follows:
   - **true:** (Default) Convert the JSON string to ColdFusion data types that correspond directly to the JSON data types.
   - **false:** Determine if the JSON string contains representations of ColdFusion queries, and if so, convert them to queries.

#### serializeJSON:

Converts ColdFusion data into a JSON (JavaScript Object Notation) representation of the data.

Arguments:

 - **var:** A ColdFusion data value or variable that represents one.
 - **serializeQueryByColumns:** A Boolean value that specifies how to serialize ColdFusion queries.
   - **false:** (Default) Creates an object with two entries: an array of column names and an array of row arrays. This format is required by the HTML format cfgrid tag.
   - **true:** Creates an object that corresponds to WDDX query format.
 - **strictMapping:** A Boolean value that specifies whether to convert the ColdFusion data strictly, as follows:
   - **false:** (Default) Convert the ColdFusion data to a JSON string using ColdFusion data types.
   - **true:** Convert the ColdFusion data to a JSON string using underlying Java/SQL data types.

Note that serialize and deserialize methods of JSONUtil 1.0 are available but have have been deprecated in JSONUtil 1.1.

### ColdSpring AOP

When requesting a remote component method with the json return format
ColdFusion uses its default implicit type conversion conventions, which
may cause issues with JavaScript clients. To work around this issue
JSONUtil comes with a ColdSpring advice class, JSONUtilAdvice.cfc,
which can be used as an advisor to ColdSpring remote proxies. In order
for remote method requests to be serialized using JSONUtils
strictMapping option you must set the returnformat to "plain" and set
the strictjson request parameter to true. Below is a sample URL:

http://localhost/myapp/service.cfc?method=myMethod&returnformat=plain&strictjson=true

The following ColdSpring configuration demonstrates how this advice
may be applied to a ColdSpring remote proxy.

```xml
<beans>

	<bean id="service" class="myapp.service" />

	<bean
		id="remoteService"
		class="coldspring.aop.framework.RemoteFactoryBean"
		lazy-init="false">

		<property name="target">
			<ref bean="service" />
		</property>
		<property name="serviceName">
			<value>remoteService</value>
		</property>
		<property name="relativePath">
			<value>/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>*</value>
		</property>
		<property name="beanFactoryName">
			<value>beanFactory</value>
		</property>
		<property name="interceptorNames">
			<list>
				<value>jsonUtilAdvisor</value>
			</list>
		</property>

	</bean>

	<bean id="jsonUtilAdvice" class="jsonutil.JSONUtilAdvice" />

	<bean
		id="jsonUtilAdvisor"
		class="coldspring.aop.support.NamedMethodPointcutAdvisor">

		<property name="advice">
			<ref bean="jsonUtilAdvice" />
		</property>
		<property name="mappedNames">
			<value>*</value>
		</property>

	</bean>

</beans>
```
