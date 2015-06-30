grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.8
grails.project.source.level = 1.8
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.fork = [
  // configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
  //  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

  // configure settings for the test-app JVM, uses the daemon by default
  //test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
  // configure settings for the run-app JVM
  //run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
  // configure settings for the run-war JVM
  //war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
  // configure settings for the Console UI JVM
  console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits("global") {
    // specify dependency exclusions here; for example, uncomment this to disable ehcache:
    // excludes 'ehcache'
  }
  log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  checksums true // Whether to verify checksums on resolve
  legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

  repositories {
    inherits true // Whether to inherit repository definitions from plugins

    grailsPlugins()
    grailsHome()
    mavenLocal()
    grailsCentral()
    mavenCentral()
  }

  // https://jira.grails.org/browse/GRAILS-11791
  management {
    // Remove this block when using a version of Grails (4.5) that uses a version of a Spring > 4.1.1
    // https://github.com/spring-projects/spring-framework/releases - update when 4.1.2
    String springVersion = '4.1.6.RELEASE' // 4.1 and 4.1.1 has bug - https://jira.spring.io/browse/SPR-12400
    dependency "org.springframework:spring-jdbc:${springVersion}"
    dependency "org.springframework:spring-context:${springVersion}"
    dependency "org.springframework:spring-aop:${springVersion}"
    dependency "org.springframework:spring-context-support:${springVersion}"
    dependency "org.springframework:spring-beans:${springVersion}"
    dependency "org.springframework:spring-core:${springVersion}"
    dependency "org.springframework:spring-tx:${springVersion}"
    dependency "org.springframework:spring-expression:${springVersion}"
    dependency "org.springframework:spring-web:${springVersion}"
    dependency "org.springframework:spring-webmvc:${springVersion}"
    dependency "org.springframework:spring-aspects:${springVersion}"
    dependency "org.springframework:spring-orm:${springVersion}" // 4.1.0.RC1 or 4.1.2.RELEASE because RC2 to 4.1.1.RELEASE have an API change not handled by Grails, see https://github.com/grails/grails-data-mapping/pull/46
    dependency "org.springframework:spring-test:${springVersion}"
    // END
  }

  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
    compile 'com.amazonaws:aws-java-sdk:1.10.2' // http://aws.amazon.com/releasenotes/Java?browse=1

    // needed for spring security
    compile "net.sf.ehcache:ehcache-core:2.6.11" //http://maven-repository.com/artifact/net.sf.ehcache/ehcache-core
  }

  plugins {
    // plugins for the build system only
    build ":tomcat:8.0.22"

    // simplifies scaling spring-security
    compile ':cookie-session:2.0.18' // http://grails.org/plugin/cookie-session
    compile ':spring-security-core:2.0-RC5'
    compile ':spring-security-userstore:0.8.5'

    compile ':aws-instance:0.7.0'
    compile ':aws-orguserteam:0.9.8'

    compile ":scaffolding:2.1.2"
    compile ':cache:1.1.8'
    compile ":asset-pipeline:2.3.8"
    compile ":less-asset-pipeline:2.3.0"

    // https://github.com/groovydev/twitter-bootstrap-grails-plugin/blob/master/README.md
    //compile ':twitter-bootstrap:3.3.4' // 3.3.0 is broken https://github.com/groovydev/twitter-bootstrap-grails-plugin/issues/121

    // plugins needed at runtime but not for compilation
    //runtime ":jquery:1.11.1"
  }
}
