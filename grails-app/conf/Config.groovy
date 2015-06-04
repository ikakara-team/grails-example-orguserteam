// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

grails.config.locations = [  "file:${System.properties['user.dir']}/${appName}-config.properties",
                             "file:${System.properties['catalina.base']}/conf/Catalina/localhost/${appName}-config.properties"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

println """*****CONFIG PROPERTIES:\n\
\tappName:""" + appName + """\n\
\tuserHome:""" + userHome + """\n\
\tbin.dir:""" + System.properties['user.dir'] + """\n\
\tcatalina.base:""" + System.properties['catalina.base'] + """\n\
\tbase.dir:""" + System.properties['base.dir'] + """\n\
"""

//System.properties.each {
//    key, value ->
//    println "${key}=${value}"
//}

///////////////////////////////////////////////////////////////////////
// Elastic Beanstalk
///////////////////////////////////////////////////////////////////////
if(System.properties['AWS_ACCESS_KEY_ID']) {
  grails.plugin.awsinstance?.accessKey = System.properties['AWS_ACCESS_KEY_ID']
}
if(System.properties['AWS_SECRET_KEY']) {
  grails.plugin.awsinstance?.secretKey = System.properties['AWS_SECRET_KEY']
}

// Environment parameters can only be 200 chars (length),
// so watch how many config items are passed in per property
def host_name
if(System.properties['PARAM1']) {
  def props_str = System.properties['PARAM1']
  if(props_str) {
    def properties = props_str.split(',')
    for(prop in properties) {
      def key_val =  prop.split('=')
      def key = key_val[0].trim()
      def val = key_val[1].trim()
      switch(key) {
      case 'region': grails.plugin.awsinstance?.defaultRegion = val
        break
      case 'host_name': host_name = val // override the hostname
        break
      case 's3bucket': grails.plugin.awsinstance?.s3.bucketName = val
        break
      case 'mailFrom': grails.plugin.awsinstance?.ses.mailFrom = val
        break
      }
    }
  }
}

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
  all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
  atom:          'application/atom+xml',
  css:           'text/css',
  csv:           'text/csv',
  form:          'application/x-www-form-urlencoded',
  html:          ['text/html','application/xhtml+xml'],
  js:            'text/javascript',
  json:          ['application/json', 'text/json'],
  multipartForm: 'multipart/form-data',
  rss:           'application/rss+xml',
  text:          'text/plain',
  hal:           ['application/hal+json','application/hal+xml'],
  xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

// GSP settings
grails {
  views {
    gsp {
      encoding = 'UTF-8'
      htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
      codecs {
        expression = 'html' // escapes values inside ${}
        scriptlet = 'html' // escapes output from scriptlets in GSPs
        taglib = 'none' // escapes output from taglibs
        staticparts = 'none' // escapes output from static template parts
      }
    }
    // escapes all not-encoded output at final stage of outputting
    // filteringCodecForContentType.'text/html' = 'html'
  }
}

grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password','accessKey','secretKey']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure passing transaction's read-only attribute to Hibernate session, queries and criterias
// set "singleSession = false" OSIV mode in hibernate configuration after enabling
grails.hibernate.pass.readonly = false
// configure passing read-only to OSIV session by default, requires "singleSession = false" OSIV mode
grails.hibernate.osiv.readonly = false

environments {
  development {
    grails.hostName = "local.dev"
    grails.serverURL = "http://${grails.hostName}:8080/${appName}"
    grails.secureServerURL = "https://${grails.hostName}:8443/${appName}"
    grails.logging.jul.usebridge = true
  }
  production {
    grails.hostName = "change.me"
    grails.serverURL = "http://www.${grails.hostName}"
    grails.secureServerURL = "https://www.${grails.hostName}"
    grails.logging.jul.usebridge = false

    // required for cookie-session plugin
    grails.plugin.springsecurity.useSessionFixationPrevention = false
    // required to enable cookie-session for spring-security
    grails.plugin.cookiesession.enabled = true
    grails.plugin.cookiesession.sessiontimeout = 3600 // one hour
    grails.plugin.cookiesession.springsecuritycompatibility = true

    // fix redirect
    grails.plugin.springsecurity.secureChannel.useHeaderCheckChannelSecurity = true
    grails.plugin.springsecurity.portMapper.httpPort = 80
    grails.plugin.springsecurity.portMapper.httpsPort = 443
    grails.plugin.springsecurity.secureChannel.secureHeaderName = 'X-Forwarded-Proto'
    grails.plugin.springsecurity.secureChannel.secureHeaderValue = 'http'
    grails.plugin.springsecurity.secureChannel.insecureHeaderName = 'X-Forwarded-Proto'
    grails.plugin.springsecurity.secureChannel.insecureHeaderValue = 'https'
  }
}

// Override the serverUrl (for staging, etc)
if(host_name) {
  grails.hostName = host_name
  grails.serverURL = "http://${host_name}"
  grails.secureServerURL = "https://${host_name}"
}

// log4j configuration
log4j.main = {
  // Example of changing the log pattern for the default console appender:
  //
  //appenders {
  //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
  //}

  error  'org.codehaus.groovy.grails.web.servlet',        // controllers
         'org.codehaus.groovy.grails.web.pages',          // GSP
         'org.codehaus.groovy.grails.web.sitemesh',       // layouts
         'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
         'org.codehaus.groovy.grails.web.mapping',        // URL mapping
         'org.codehaus.groovy.grails.commons',            // core / classloading
         'org.codehaus.groovy.grails.plugins',            // plugins
         'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
         'org.springframework',
         'org.hibernate',
         'net.sf.ehcache.hibernate'
  debug  'grails.app'
}

// Added by the Spring Security Core plugin:
//grails.plugin.springsecurity.active = false
grails.plugin.springsecurity.auth.forceHttps=true
grails.plugin.springsecurity.successHandler.defaultTargetUrl="/welcome"
//grails.plugin.springsecurity.logout.postOnly=false // make it easier to test
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
  '/':                              ['permitAll'],
  '/assets/**':                     ['permitAll'],
  '/**/js/**':                      ['permitAll'],
  '/**/css/**':                     ['permitAll'],
  '/**/images/**':                  ['permitAll'],
  '/**/favicon.ico':                ['permitAll'],
  '/sign-up':                       ['permitAll'],
  '/my-*/**':                       ['ROLE_USER'],
  '/admin':                         ['ROLE_ADMIN'],
  '/sys*/**':                       ['ROLE_ADMIN'],
]

grails.plugin.springsecurity.secureChannel.definition = [
  '/grails/**':           'ANY_CHANNEL',
  '**':                   'REQUIRES_SECURE_CHANNEL',
]

// Added by the Spring Security Userstore plugin:
grails.plugin.springsecurity.userstore.publishableKey = ""
grails.plugin.springsecurity.userstore.secretKey = ""
//grails.plugin.springsecurity.userstore.requireEmailVerifiedOnSignin = true
grails.plugin.springsecurity.userstore.defaultSettingsUrl = "/my-settings"
