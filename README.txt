#################################
Common Maven Build Commands
#################################

#################################
Setting system properties:
#################################
For Mac:
export jboss.server.config.dir=/Applications/jboss/jboss-as-7.1.1.Final/standalone/configuration (replace with your directory location)
For PC:
set  jboss.server.config.dir=/Applications/jboss/jboss-as-7.1.1.Final/standalone/configuration (replace with your directory location)


#################################
Database Setup:
#################################
To create the database schema:
mvn clean compile exec:java


To create the database schema and specify the location of insert scripts:
mvn clean compile exec:java

To create the database schema and auto-populate with views and sample data within couchdb:
mvn clean compile generate-resources exec:java

#################################
Build tips & tricks:
#################################
To speed up the GWT compilation, can use -Dgwt.draftCompile=true (http://mojo.codehaus.org/gwt-maven-plugin/compile-mojo.html). For example:
mvn clean package -Dgwt.draftCompile=true

Also, to speed up the GWT compilation, update Renovo.gwt.xml and Subscribe.gwt.xml to only process for one browser.
Complete list of user agents can be found at http://code.google.com/p/google-web-toolkit/source/browse/trunk/user/src/com/google/gwt/useragent/UserAgent.gwt.xml

#################################
Running the app:
#################################
To build the war artifact to the target directory of the project, run the following command:
mvn package

If you would like to have that deployment war file copied to your web container deploy directory (if using tomcat or jboss or instance),
uncomment the 'outputDirectory' element of the maven-war-plugin plugin and set the 'jboss.server.deploy.dir' property to your deployment directory for jboss or tomcat.
This will then automatically cause the deployment war to be copied to that directory upon building.

To deploy the war artifact to JBoss as part of maven build via the jboss network admin api, run following command:
mvn package jboss-as:deploy

To deploy to JBoss without running GWT compiler, run following command:
mvn package -Pignoregwt


To run the GWT debugger
mvn gwt:debug
The debug console will load, then just click the "Copy to Clipboard" button and paste the URL in your browser.

To skip tests
mvn package -DskipTests=true

******* App Modes *******
Add the desired app mode request parameter to the end of the app URL:
Customer Support Admin: &mode=evadmin
Enterprise Admin: &mode=defaultmode
Subscribe/Signup: &mode=subscribe

##########################
Undeploy from JBoss
##########################
./jboss-cli.sh
connect
undeploy renovo-0.2.0.BUILD-SNAPSHOT.war


##########################
Running tests
##########################

mvn package or mvn test will run all tests that end in Test.java found in either the integration or unit directories
but the convention is that only unit tests end in Test.java.

mvn integration-test -Pit can be used to run all of the unit tests and all of the integration tests.  Note: the integration-test
phase is after the package phase (so the war will be deployed as it is part of our package).

mvn integration-test -Pit -Dit.test=**/[Class name] can be used to run a specific integration test.  Note that using the absolute java
name (including the package structure) which would normally be supported by failsafe does not work but using the wildcards will cause the
test to be executed.  Note 2 this will also run all of the unit tests and package the war so you may also want to add -Pigoregwt as well.

You may also run any or all of the integration or unit tests individually or by directory in your IDE.  I have not tested
that the Maven setup treats the integration directory as a test directory in Eclipse but it does in IntelliJ.


##########################
JBoss server configuration
##########################

To enable remote debugging of the app when deployed to JBoss, the following should be added
to the standalone.conf JBoss file (under JBOSS_HOME/bin/ directory)

JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"


The following should be added to the standalone.xml JBoss file (under standalone/configuration/ directory)

                <security-domain name="renovo" cache-type="default">
                    <authentication>
                        <login-module code="com.everifile.renovo.server.container.jboss.security.DataSourceLoginModule" flag="required"/>
                    </authentication>
                </security-domain>

Update the following line in the standalone.xml to include native support:
  <subsystem xmlns="urn:jboss:domain:web:1.1" default-virtual-server="default-host" native="true">


To undeploy a renovo war file already deployed via maven, you can use the jboss cli.  For example:
C:\Software\JBoss\jboss-as-7.1.1.Final\bin>jboss-cli
You are disconnected at the moment. Type 'connect' to connect to the server or 'help' for the list of supported commands.
[disconnected /] connect
[standalone@localhost:9999 /] undeploy renovo-0.1.0.BUILD-SNAPSHOT.war


to run in hot deploy mode:
* undeploy the app as noted above
* copy your directory on over to the deployments directory (make sure you rename the directory .war)

	rm -rf /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war
	cp -r target/renovo-0.2.0.BUILD-SNAPSHOT /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war

* note that to make sure that it gets picked up, you may have to create another file called xxx.dodeploy

	touch /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war.dodeploy

* pull your changes back in from the deployment directory:

	cp -rf /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war/css src/main/webapp
	cp -rf /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war/javascripts src/main/webapp
	cp -rf /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war/reports src/main/webapp
	cp -rf /Applications/jboss-as-7.1.1.Final/standalone/deployments/renovo-0.2.0.BUILD-SNAPSHOT.war/api src/main/webapp

* to create the war without deploying:

   mvn clean package -Pignoregwt -Pdontdeploy

* to minimally deploy the way
   mvn clean package jboss-as:deploy -Pignoregwt


to run for environment mars:

	mvn clean package exec:java -Pignoregwt -DenvironmentName=mars

to run for override

	mvn clean package exec:java -Pignoregwt -DenvironmentFilename=/Users/azuercher/workspace/renovo-web/src/main/resources/renovo-unittest.properties
