<!DOCTYPE html>
<html>
  <head>
    <title><g:message code="error.500.title"/> - Example OUT</title>
    <meta name="layout" content="main">
  <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
  </head>
  <body>
    <h3><g:message code="error.500.header"/></h3>
  <p><g:message code="error.500.problemreported"/> <a href="${request.contextPath}/"><g:message code="navigation.gobackhome"/></a>.</p>
  <p><a href="mailto:info@change.me"><g:message code="general.tellus"/></a>.</p>

  <g:if env="development">
    <g:renderException exception="${exception}" />
  </g:if>

<!-- script references -->
<content tag="javascript">
  <script type="text/javascript" charset="utf-8">

  </script>
</content>
</body>
</html>
