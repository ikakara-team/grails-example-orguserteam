<%@ page import = "grails.plugin.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name='layout' content='main'/>
    <title>Reset Password</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body id="reset-password" class="auth-page">
    <h3>Reset Password</h3>
    <div class="content">
      <div id="reset-password-container">
        <noscript>Resetting your password requires Javascript.  Please enable Javascript in your browser.</noscript>
      </div>
    </div>
  <!-- script references -->
  <content tag="javascript">
    <script src="https://api.userstore.io/1/js/userstore.js"></script>
    <script type="text/javascript" charset="utf-8">
      UserStore.setPublishableKey('${SpringSecurityUtils?.securityConfig.userstore.publishableKey}');
      window.onload = function() {
      UserStore.renderResetPassword({
      container: 'reset-password-container', // required
      errorURL: '${request.contextPath}/forgot-password', // required
      successURL: '${request.contextPath}/reset-password', // optional
      messages: { // optional
      placeholders: {
      password: 'Password',
      passwordConfirm: 'Retype Password'
      },
      labels: {
      submitButton: 'Reset Password'
      }
      },
      options: { // optional
      renderBootstrapClasses: true
      }
      });
      }
    </script>
  </content>
</body>
</html>
