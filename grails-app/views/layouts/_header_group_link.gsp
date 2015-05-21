<g:if test="${usergroup instanceof ikakara.orguserteam.dao.dynamo.IdUserOrg}">
  <a data-toggle="modal" href="${request.contextPath}/${usergroup.group.aliasId}/${org_path}"><i class="fa fa-sitemap"></i> ${usergroup.group.name}</a>
</g:if>
<g:elseif test="${usergroup instanceof ikakara.orguserteam.dao.dynamo.IdUserFolder}">
  <a data-toggle="modal" href="${request.contextPath}/${usergroup.group.aliasId}/${folder_path}"><i class="fa fa-folder"></i> ${usergroup.group.name}</a>
</g:elseif>
<g:else>
  println "${usergroup.class}"
</g:else>