<g:if test="${org}">
  <a href="${request.contextPath}/${org.aliasId}/folders"><g:message code="dashboard.label.org" />: ${org.name}</a>
</g:if>
<g:elseif test="${folder.isOwnerOrg()}">
  <a href="#"><g:message code="dashboard.label.org" />: ${folder.owner?.name}</a>
</g:elseif>
<g:else>
  <a href="#"><g:message code="dashboard.label.owner" />: ${folder.owner?.name}</a>
</g:else>