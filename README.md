# grails-example-orguserteam

Description:
--------------
This grails app is an example for the grails aws-orguserteam plugin.  It relies on
the following plugins:

| BuildConfig | grails plugin | readme |
|--------|-----|---------|
|compile ':cookie-session:2.0.18'|http://grails.org/plugin/cookie-session|https://github.com/benlucchesi/grails-cookie-session-v2|
|compile ':spring-security-core:2.0-RC5'|http://grails.org/plugin/spring-security-core|https://github.com/grails-plugins/grails-spring-security-core|
|compile ':spring-security-userstore:0.8.3'|http://grails.org/plugin/spring-security-userstore|https://github.com/ikakara-team/grails-spring-security-userstore|
|compile ':aws-instance:0.6.7'|http://grails.org/plugin/aws-instance|https://github.com/ikakara-team/grails-aws-instance|
|compile ':aws-orguserteam:0.9.7'|http://grails.org/plugin/aws-orguserteam|https://github.com/ikakara-team/grails-aws-orguserteam|

Dependent SOA Services:
--------------
* AWS and requires the following (FREE Tier) services: dynamodb, s3, ses, elasticbeanstalk (ec2, elasticloadbalancing, vpc), iam
  * See <a href="https://github.com/ikakara-team/grails-aws-instance">aws-instance README</a> for configuration
* UserStore.io - (In private beta)
  * See <a href="https://github.com/ikakara-team/grails-spring-security-userstore">spring-security-userstore README</a> for configuration

Development Setup:
--------------
1. Download and install latest Java 8 http://www.oracle.com/technetwork/java/javase/downloads/index.html
  * Configure JAVA_HOME
2. Download and install Grails 2.5 https://grails.org/download.html
  * https://grails.org/documentation.html
  * Configure GRAILS_HOME
3. Configure grails-app/conf/Config.groovy
  * ```grails.plugin.springsecurity.userstore.publishableKey = ""```
  * ```grails.plugin.springsecurity.userstore.secretKey = ""```
4. Configure exampleout-config.properties:
  * ```grails.plugin.awsinstance.accessKey=```
  * ```grails.plugin.awsinstance.secretKey=```
  * ```grails.plugin.awsinstance.s3.bucketName=```
  * ```grails.plugin.awsinstance.ses.mailFrom=```
5. Update (Windows) Enviroment: edit \Windows\System32\drivers\etc\hosts
  * ```127.0.0.1       localhost```
6. >grails compile
7. >grails run-app -https

Production Configuration:
--------------
AWS ElasticBeanStalk environment properties:
* AWS_ACCESS_KEY_ID
* AWS_SECRET_KEY
* PARAM1
  * venues=,mailFrom=,host_name=

AWS Configuration:
--------------
Create S3 bucket and configure bucket policy:
```
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::[BUCKET_NAME]/*"
    }
  ]
}
```

Special Thanks:
--------------
* <a href="http://devoops.me/handmade/3/">Devoops</a> for use of their bootstrap template
* <a href="http://plugins.krajee.com/file-input">File Input</a> for video upload
* <a href="http://www.fancyapps.com/fancybox/">fancyBox</a> for video gallery

Copyright & License:
--------------
Copyright 2014-2015 Allen Arakaki.  All Rights Reserved.

```
Apache 2 License - http://www.apache.org/licenses/LICENSE-2.0
```

History:
--------------
```
1.0 - init checkin
```