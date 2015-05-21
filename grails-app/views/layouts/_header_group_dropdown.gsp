<%
def memberGroup = request.getAttribute(ikakara.exampleout.web.app.DashboardUserController.MEMBER_KEY)
def found
if(folder) {
  // check if user also member of folder
  found = memberGroup?.find { it.group.id == folder.id }
}
%>
<g:if test="${!found}">
  <ul class="nav navbar-nav panel-menu" style="padding-left: 2em;">
    <li class="dropdown">
      <a id="apps" class="dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-sitemap"></i>
        <span class="hidden-xs">${org.name}</span>
        <i class="fa fa-angle-down pull-right"></i>
      </a>
      <ul id="ulapps" class="dropdown-menu dropdown-messages">
        <g:each status="i" in="${memberGroup}" var="usergroup">
          <g:if test="${org?.id != usergroup.group.id}">
            <li>
              <g:render template="/layouts/header_group_link"  model="['usergroup': usergroup, 'org_path': org_path, 'folder_path': folder_path]"/>
            </li>
          </g:if>
        </g:each>
        <li class="divider"></li>
        <li><a data-toggle="modal" href="#addNewFolderModal"><i class="fa fa-plus-circle"></i> <g:message code="dashboard.newfolder" /></a></li>
        <li><a data-toggle="modal" href="#addNewOrgModal"><i class="fa fa-plus-circle"></i> <g:message code="dashboard.neworg" /></a></li>
      </ul>
    </li>
  </ul>
</g:if>
<g:else>
  <ul class="nav navbar-nav panel-menu" style="padding-left: 2em;">
    <li class="dropdown">
      <a id="apps" class="dropdown-toggle" data-toggle="dropdown" href="#">
        <i class="fa fa-folder"></i>
        <span class="hidden-xs">${folder.name}</span>
        <i class="fa fa-angle-down pull-right"></i>
      </a>
      <ul id="ulapps" class="dropdown-menu dropdown-messages">
        <g:each status="i" in="${memberGroup}" var="usergroup">
          <g:if test="${folder?.id != usergroup.group.id}">
            <li>
              <g:render template="/layouts/header_group_link"  model="['usergroup': usergroup, 'org_path': org_path, 'folder_path': folder_path]"/>
            </li>
          </g:if>
        </g:each>
        <li class="divider"></li>
        <li><a data-toggle="modal" href="#addNewFolderModal"><i class="fa fa-plus-circle"></i> <g:message code="dashboard.newfolder" /></a></li>
        <li><a data-toggle="modal" href="#addNewOrgModal"><i class="fa fa-plus-circle"></i> <g:message code="dashboard.neworg" /></a></li>
      </ul>
    </li>
  </ul>
</g:else>
