<%
def active_folders
def active_members
def active_profile
switch(org_path) {
case 'folders': active_folders = 'active-parent active'; break;
case 'members': active_members = 'active-parent active'; break;
case 'profile': active_profile = 'active-parent active'; break;
}
%>
<ul class="nav main-menu">
  <li>
    <a class="${active_folders}" href="${request.contextPath}/${org.aliasId}/folders">
      <i class="fa fa-folder"></i>
      <span class="hidden-xs">Folders</span>
    </a>
  </li>
  <li>
    <a class="${active_members}" href="${request.contextPath}/${org.aliasId}/members">
      <i class="fa fa-users"></i>
      <span class="hidden-xs">Org Members</span>
    </a>
  </li>
  <li>
    <a class="${active_profile}" href="${request.contextPath}/${org.aliasId}/profile">
      <i class="fa fa-adjust"></i>
      <span class="hidden-xs">Profile</span>
    </a>
  </li>
</ul>