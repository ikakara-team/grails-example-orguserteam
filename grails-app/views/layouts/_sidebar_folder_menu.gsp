<%
def active_videos
def active_members
def active_profile
switch(folder_path) {
case 'videos': active_videos = 'active-parent active'; break;
case 'members': active_members = 'active-parent active'; break;
case 'profile': active_profile = 'active-parent active'; break;
}
%>
<ul class="nav main-menu">
  <g:if test="${org}">
    <g:render template="/layouts/sidebar_folder_dropdown" model="['folder': folder, 'org': org, 'listFolder': listFolder, 'folder_path': folder_path]" />
  </g:if>
  <li>
    <a class="${active_videos}" href="${request.contextPath}/${folder.aliasId}/videos">
      <i class="fa fa-file-video-o"></i>
      <span class="hidden-xs">Videos</span>
    </a>
  </li>
  <li>
    <a class="${active_members}" href="${request.contextPath}/${folder.aliasId}/members">
      <i class="fa fa-users"></i>
      <span class="hidden-xs">Folder Members</span>
    </a>
  </li>
  <li>
    <a class="${active_profile}" href="${request.contextPath}/${folder.aliasId}/profile">
      <i class="fa fa-adjust"></i>
      <span class="hidden-xs">Profile</span>
    </a>
  </li>
</ul>