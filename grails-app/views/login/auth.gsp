<%@ page import = "grails.plugin.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name='layout' content='main'/>
    <title>Sign In</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body id="signin" class="auth-page">
    <h3>Sign In</h3>
    <%
def exception = session[org.springframework.security.web.WebAttributes.AUTHENTICATION_EXCEPTION]
if(exception && exception instanceof com.userstore.auth.EmailNotVerifiedException) {
  flash.message = exception.getMessage()
}
%>
    <div class="content">
      <g:if test='${flash.message}'>
        <div class='login_message'>${flash.message}</div>
      </g:if>
      <div id="signin-container">
        <noscript>Sign-in requires Javascript.  Please enable Javascript in your browser.</noscript>
      </div>
    </div>
    <div class="bottom-wrapper">
      <div class="message">
        <span>Don't have an account?</span>
        <a href="${request.contextPath}/sign-up">Sign up here</a>.
      </div>
    </div>

<!-- script references -->
  <content tag="javascript">
    <script src="https://api.userstore.io/1/js/userstore.js"></script>
    <script type="text/javascript" charset="utf-8">
      window.onload = function() {
      UserStore.setPublishableKey('${SpringSecurityUtils?.securityConfig.userstore.publishableKey}');
      UserStore.renderSignIn({
      successURL: '${request.contextPath}/j_spring_security_check', // optional
      messages: {
      placeholders: {
      signinId: 'Your email',
      password: 'Password'
      },
      labels: {
      signinId: 'Email Address',
      submitButton: 'Sign In'
      }
      },
      options: {
      forgotPasswordURL: '${request.contextPath}/forgot-password',
      renderBootstrapClasses: true
      },
      container: 'signin-container'
      });
      }
    </script>
  </content>
</body>
</html>
