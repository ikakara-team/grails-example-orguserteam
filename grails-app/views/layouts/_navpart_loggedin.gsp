<sec:ifNotLoggedIn>
  <li><a href="${request.contextPath}/sign-up">Register</a></li>
  <li><a href="${request.contextPath}/sign-in">Login</a></li>
</sec:ifNotLoggedIn>
<sec:ifLoggedIn>
  <% def invitedGroup = request.getAttribute(ikakara.exampleout.web.app.DashboardUserController.INVITED_KEY) %>
  <g:if test="${invitedGroup}">
    <li class="hidden-xs">
      <a href="${request.contextPath}/my-memberships">
        <i class="fa fa-envelope" style="padding-top:10px;"></i>
        <span class="badge">${invitedGroup?.size()}</span>
      </a>
    </li>
  </g:if>
  <li class="dropdown">
    <a href="#" class="dropdown-toggle account" data-toggle="dropdown">
      <div class="avatar">
        <i class="fa fa-user"></i>
        <!--asset:image src="devoops/avatar.jpg" class="img-rounded" alt="avatar" /-->
      </div>
      <i class="fa fa-angle-down pull-right"></i>
      <div class="user-mini pull-right">
        <span class="welcome">Welcome,</span>
        <span><sec:loggedInUserInfo field="full_name"/></span>
      </div>
    </a>
    <g:form name="logout" uri="/logout" method="POST" ></g:form>
      <ul class="dropdown-menu">
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
  </li>
</sec:ifLoggedIn>