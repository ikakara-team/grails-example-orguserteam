<!DOCTYPE html>
<html>
  <head>
    <title><g:message code="error.403.title"/> - Example OUT</title>
    <meta name="layout" content="main">
  <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
  </head>
  <body>
    <div class="content">
      <h3><g:message code="error.403.title"/></h3>
    <p><g:message code="error.403.header"/></p>
    <p><g:message code="error.403.reachedinerror"/> <a href="mailto:info@change.me"><g:message code="error.403.letusknow"/></a>.</p>
    <p><a href="javascript:window.history.go(-1)"><g:message code="navigation.gobacktryagain"/></a>.</p>
    <p><a href="${request.contextPath}/"><g:message code="navigation.gobackhome"/></a>.</p>

    <g:if env="development">
      <g:renderException exception="${exception}" />
    </g:if>
  </div>

<!-- script references -->
<content tag="javascript">
  <script type="text/javascript" charset="utf-8">

  </script>
</content>
</body>
</html>
