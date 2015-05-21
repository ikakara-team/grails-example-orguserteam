<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="platform"/>
    <title>System Config</title>
    <style type="text/css" media="screen">
      #status {
      background-color: #eee;
      border: .2em solid #fff;
      margin: 2em 2em 1em;
      padding: 1em;
      width: 12em;
      float: left;
      -moz-box-shadow: 0px 0px 1.25em #ccc;
      -webkit-box-shadow: 0px 0px 1.25em #ccc;
      box-shadow: 0px 0px 1.25em #ccc;
      -moz-border-radius: 0.6em;
      -webkit-border-radius: 0.6em;
      border-radius: 0.6em;
      }

      .ie6 #status {
      display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
      }

      #status ul {
      font-size: 0.9em;
      list-style-type: none;
      margin-bottom: 0.6em;
      padding: 0;
      }

      #status li {
      line-height: 1.3;
      }

      #page-body {
      margin: 2em 1em 1em 18em;
      }

      p {
      line-height: 1.5;
      margin: 0.25em 0;
      }

      #controller-list {
      margin: 2em 1em 1em 17em;
      }

      #controller-list ul {
      list-style-position: inside;
      }

      #controller-list li {
      line-height: 1.3;
      list-style-position: inside;
      margin: 0.25em 0;
      }

      @media screen and (max-width: 480px) {
      #status {
      display: none;
      }

      #page-body {
      margin: 0 1em 1em;
      }

      #page-body h1 {
      margin-top: 0;
      }

      #controller-list {
      margin: 0;
      }
      }
    </style>
  </head>
  <body>
    <a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
    <div>
      <div id="status" role="complementary">
        <h1>Application Status</h1>
        <ul>
          <li>App version: <g:meta name="app.version"/></li>
          <li>Grails version: <g:meta name="app.grails.version"/></li>
          <li>Groovy version: ${GroovySystem.getVersion()}</li>
          <li>JVM version: ${System.getProperty('java.version')}</li>
          <li>Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</li>
          <li>Controllers: ${grailsApplication.controllerClasses.size()}</li>
          <li>Domains: ${grailsApplication.domainClasses.size()}</li>
          <li>Services: ${grailsApplication.serviceClasses.size()}</li>
          <li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>
        </ul>
        <h1>Installed Plugins</h1>
        <ul>
          <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
            <li>${plugin.name} - ${plugin.version}</li>
            </g:each>
        </ul>
      </div>
      <div id="page-body" role="main">
        <div class="dialog">
          <h1>Config Properties:</h1>
          <ul>
            <li>AWS_ACCESS_KEY_ID = ${System.properties['AWS_ACCESS_KEY_ID']}</li>
            <li>AWS_SECRET_KEY = ${System.properties['AWS_SECRET_KEY']}</li>
            <li>JDBC_CONNECTION_STRING = ${System.properties['JDBC_CONNECTION_STRING']}</li>
            <li>PARAM1 = ${System.properties['PARAM1']}</li>
            <li>PARAM2 = ${System.properties['PARAM2']}</li>
            <li>PARAM3 = ${System.properties['PARAM3']}</li>
            <li>PARAM4 = ${System.properties['PARAM4']}</li>
            <li>PARAM5 = ${System.properties['PARAM5']}</li>
            <li>amazonaws.accessKey = ${grailsApplication.config.grails.plugin.awsinstance?.accessKey}</li>
            <li>amazonaws.secretKey = ${grailsApplication.config.grails.plugin.awsinstance?.secretKey}</li>
            <li>amazonaws.lobBucketName = ${grailsApplication.config.grails.plugin.awsinstance?.s3.bucketName}</li>
            <li>amazonaws.lobBucketHost = ${grailsApplication.config.grails.plugin.awsinstance?.s3.bucketHost}</li>
            <li>amazonaws.ses.mailFrom = ${grailsApplication.config.grails.plugin.awsinstance?.ses.mailFrom}</li>
            <li>Host name: ${grailsApplication.config.grails.hostName}</li>
            <li>Server URL: ${grailsApplication.config.grails.serverURL}</li>
            <li>Secure URL: ${grailsApplication.config.grails.secureServerURL}</li>
          </ul>
        </div>
        <div class="dialog">
          <h1>JAVA OPTs:</h1>
          <ul>
            <%
// get the system environment variables
Map<String,String> envMap1 = System.getenv();
%>
            <g:each var="key" in="${envMap1.keySet()}">
              <% if(key.equals("JAVA_OPTS")) { %>
              <li>${key} = ${envMap1.get(key)}</li>
                <% } %>
              </g:each>
          </ul>
        </div>
        <div class="dialog">
          <h1>Environment Variables:</h1>
          <ul>
            <%
// get the system environment variables
Map<String,String> envMap = System.getenv();
            %>
            <g:each var="key" in="${envMap.keySet()}">
              <% if(!key.equals("JAVA_OPTS")) { %>
              <li>${key} = ${envMap.get(key)}</li>
                <% } %>
              </g:each>
          </ul>
        </div>
        <div class="dialog">
          <h1>System Properties:</h1>
          <ul>
            <%
Properties p = System.getProperties();
            %>
            <g:each var="key" in="${p.keys()}">
              <li>${key} = ${p.get(key)}</li>
              </g:each>
          </ul>
        </div>
      </div>
      <div id="controller-list" role="navigation">
        <h1>Available Controllers:</h1>
        <ul>
          <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
            <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
            </g:each>
        </ul>
      </div>
    </div>
  </body>
</html>
