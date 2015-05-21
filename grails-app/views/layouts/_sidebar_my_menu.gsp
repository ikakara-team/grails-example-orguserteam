<%
def active_memberships
def active_profile
def active_settings
switch(my_path) {
case 'memberships': active_memberships = 'active-parent active'; break;
case 'profile': active_profile = 'active-parent active'; break;
case 'settings': active_settings = 'active-parent active'; break;
}
%>
<ul class="nav main-menu">
  <li>
    <a class="${active_memberships}" href="${request.contextPath}/my-memberships">
      <i class="fa fa-group"></i>
      <span class="hidden-xs">My Memberships</span>
    </a>
  </li>
  <li>
    <a class="${active_profile}" href="${request.contextPath}/my-profile">
      <i class="fa fa-user"></i>
      <span class="hidden-xs">My Profile</span>
    </a>
  </li>
  <li>
    <a class="${active_settings}" href="${request.contextPath}/my-settings">
      <i class="fa fa-cog"></i>
      <span class="hidden-xs">My Settings</span>
    </a>
  </li>
</ul>
