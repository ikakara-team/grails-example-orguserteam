<ul class="nav navbar-top-links navbar-right">
  <li><a href="${request.contextPath}/admin">Info</a></li>
  <li class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      <i class="">Data</i> <span class="caret"></span>
    </a>
    <ul class="dropdown-menu dropdown-messages">
      <li><a href="${request.contextPath}/sysOrg/index">Orgs</a></li>
      <li><a href="${request.contextPath}/sysFolder/index">Folders</a></li>
      <li><a href="${request.contextPath}/sysUser/index">Users</a></li>
      <li><a href="${request.contextPath}/sysEmail/index">Emails</a></li>
      <li><a href="${request.contextPath}/sysSlug/index">Slugs</a></li>
    </ul>
    <!-- /.dropdown-messages -->
  </li>

  <sec:ifLoggedIn>
    <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
        <i class=""><sec:loggedInUserInfo field="full_name"/></i> <span class="caret"></span>
      </a>
      <g:form name="logout" uri="/logout" method="POST" ></g:form>
        <ul class="dropdown-menu dropdown-messages">
          <li>
            <a href="${request.contextPath}/my-memberships"><i class="fa fa-group"></i> <span>Memberships</span></a>
        </li>
        <li>
          <a href="${request.contextPath}/my-profile"><i class="fa fa-user"></i> <span>Profile</span></a>
        </li>
        <li>
          <a href="${request.contextPath}/my-settings"><i class="fa fa-cog"></i> <span>Settings</span></a>
        </li>
        <li>
          <a href='javascript:$("#logout").submit();'><i class="fa fa-power-off"></i> <span>Logout</span></a>
        </li>
      </ul>
      <!-- /.dropdown-messages -->
    </li>
  </sec:ifLoggedIn>
</ul>
