<%@ page import = "grails.plugin.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name='layout' content='main'/>
    <title>Forgot Password</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body id="forgot-password" class="auth-page">
    <h3>Forgot Password</h3>
    <div class="content">
      <div id="forgot-password-container">
        <noscript>Recovering your password requires Javascript.  Please enable Javascript in your browser.</noscript>
      </div>
    </div>
  <!-- script references -->
  <content tag="javascript">
    <script src="https://api.userstore.io/1/js/userstore.js"></script>
    <script type="text/javascript" charset="utf-8">
      UserStore.setPublishableKey('${SpringSecurityUtils?.securityConfig.userstore.publishableKey}');
      window.onload = function() {
      UserStore.renderForgotPassword({
      container: 'forgot-password-container',
      options: {
      renderBootstrapClasses: true
      }
      });
      }
    </script>
  </content>
</body>
</html>
