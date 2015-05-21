<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Folders</title>
  </head>
  <body>
    <div id="main" class="container-fluid">
      <div class="row">
        <div id="sidebar-left" class="col-xs-2 col-sm-2">
          <g:render template="/layouts/sidebar_org_menu" model="['org_path': org_path]" />
        </div>

        <!--Start Content-->
        <div id="content" class="col-xs-12 col-sm-10">
          <!--Start Breadcrumb-->
          <div class="row">
            <div id="breadcrumb" class="col-xs-12">
              <ol class="breadcrumb">
                <li><a href="#"><g:message code="dashboard.label.org" />: ${org.name}</a></li>
                <li><a href="#">Folders</a></li>
              </ol>
            </div>
          </div>
          <!--End Breadcrumb-->
          <!--Start Dashboard 1-->
          <div id="dashboard-header" class="row">
            <div class="col-xs-8 col-sm-6">
              <h3>${org.name} Folders</h3>
            </div>
            <!--div class="clearfix visible-xs"></div-->
            <div class="col-xs-4 col-sm-6 pull-right">
              <div class="btn-group pull-right">
                <a  class="btn btn-primary" data-toggle="modal" data-orgid="${org.aliasId}" href="#addNewFolderModal">
                  <i class="fa fa-folder"></i>
                  <span class="hidden-xs"><g:message code="dashboard.createfolder" /></span>
                </a>
              </div>
            </div>
          </div>
          <!--End Dashboard 1-->

          <g:if test="${flash.message}">
            <div class="row">
              <div class="col-xs-12 page-feed">
                <div class="message" role="status">${flash.message}</div>
              </div>
            </div>
          </g:if>
          <!-- -->
          <div class="row">
            <g:each status="i" in="${listFolder}" var="orgfolder">
              <%
def orgUserTeamService = grailsApplication.mainContext.getBean("orgUserTeamService");
def userfolder = orgfolder.group.hasMember(user)
def userfolderRole = ''
if(userfolder) {
  userfolderRole = "You are the ${userfolder.memberRoles}"
}
def list = orgUserTeamService.listUser(orgfolder.group)
              %>
              <g:render template="/layouts/part_folder" model="['folder':orgfolder.group, 'memberList':list, 'userRole':userfolderRole]" />
            </g:each>

          </div>

          <div style="height: 40px;"></div>

        </div>
        <!--End Content-->

      </div>
    </div>
  <!-- script references -->
  <content tag="javascript">
    <script type="text/javascript" charset="utf-8">

    </script>
  </content>
</body>
</html>
