<%@ page import = "grails.plugin.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name='layout' content='main'/>
    <title>Verify Success</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body id="signup" class="auth-page">
    <h3>Congratulations, ${user.email} is verified!</h3>
    <p><a href="${request.contextPath}/welcome">Continue ...</a></p>
  </body>
</html>
