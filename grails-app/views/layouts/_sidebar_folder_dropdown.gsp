<g:if test="${folder}">
  <li class="dropdown">
    <a href="#" class="dropdown-toggle">
      <i class="fa fa-folder"></i>
      <span class="hidden-xs">${folder?.name} <g:render template="/layouts/part_folder_privacy" model="['folder': folder]" /></span>
      <div style="float: right;"><span class="caret"></span></div>
    </a>
    <ul class="dropdown-menu">
      <g:each status="i" in="${listFolder}" var="objfolder">
        <g:if test="${folder?.id != objfolder.group.id}">
          <li>
            <a href="${request.contextPath}/${objfolder.group.aliasId}/${folder_path}">${objfolder.group.name} <g:render template="/layouts/part_folder_privacy" model="['folder': objfolder.group]" /></a>
          </li>
        </g:if>
      </g:each>
      <li>
        <a data-toggle="modal" data-orgid="${org.aliasId}" href="#addNewFolderModal">
          <i class="fa fa-plus-circle"></i>
          <g:message code="dashboard.createfolder" />
        </a>
      </li>
    </ul>
  </li>
</g:if>
<g:else>
  <li>
    <a data-toggle="modal" data-orgid="${org.aliasId}" href="#addNewFolderModal">
      <i class="fa fa-plus-circle"></i>
      <g:message code="dashboard.createfolder" />
    </a>
  </li>
</g:else>