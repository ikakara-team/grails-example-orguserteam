<%@ page import = "grails.plugin.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name='layout' content='main'/>
    <title>Sign Up</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body id="signup" class="auth-page">
    <h3>Sign Up</h3>
    <div class="content">
      <div id="signup-container">
        <noscript>Sign-up requires Javascript.  Please enable Javascript in your browser.</noscript>
      </div>
    </div>
  <!-- script references -->
  <content tag="javascript">
    <script src="https://api.userstore.io/1/js/userstore.js"></script>
    <script type="text/javascript" charset="utf-8">
      UserStore.setPublishableKey('${SpringSecurityUtils?.securityConfig.userstore.publishableKey}');
      window.onload = function() {
      UserStore.renderSignUp({
      successURL: '${request.contextPath}/sign-up-callback', // optional
      container: 'signup-container',
      options: {
      fields: 'username,first_name,last_name,email,password',
      renderBootstrapClasses: true
      }
      });
      }
    </script>
  </content>
</body>
</html>
