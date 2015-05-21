<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Members</title>
  </head>
  <body>
    <div id="main" class="container-fluid">
      <div class="row">
        <div id="sidebar-left" class="col-xs-2 col-sm-2">
          <g:render template="/layouts/sidebar_folder_menu" model="['folder': folder, 'org': org, 'listFolder': listFolder, 'folder_path': folder_path]" />
        </div>

        <!--Start Content-->
        <div id="content" class="col-xs-12 col-sm-10">
          <!--Start Breadcrumb-->
          <div class="row">
            <div id="breadcrumb" class="col-xs-12">
              <ol class="breadcrumb">
                <li><g:render template="/layouts/dashboard_breadcrumb_org" model="['org': org, 'folder': folder]" /></li>
                <li><a href="${request.contextPath}/${folder.aliasId}"><g:message code="dashboard.label.folder" />: ${folder.name}</a></li>
                <li><a href="#">Members</a></li>
              </ol>
            </div>
          </div>
          <!--End Breadcrumb-->
          <!--Start Dashboard 1-->
          <div id="dashboard-header" class="row">
            <div class="col-xs-8 col-sm-6">
              <h3>${folder.name} <g:render template="/layouts/part_folder_privacy" model="['folder': folder]" /></h3>
            </div>
            <!--div class="clearfix visible-xs"></div-->
            <div class="col-xs-4 col-sm-6 pull-right">
              <div class="btn-group pull-right">
                <a title="New Member" data-toggle="modal" href="#inviteFolderMemberModal" class="btn btn-primary">
                  <i class="fa fa-user-plus"></i> <span class="hidden-xs"><g:message code="dashboard.invitemember" /></span></a>
                  <g:if test="${listAdd}">
                  <a title="Add Member" data-toggle="modal" href="#addFolderMemberModal" class="btn btn-primary">
                    <i class="fa fa-plus-circle"></i> <span class="hidden-xs"><g:message code="dashboard.addmember" /></span></a>
                  </g:if>
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

          <!--Start Dashboard 2-->
          <div class="row-fluid">
            <div id="dashboard_links" class="col-xs-12 col-sm-2 pull-right">
              <ul class="nav nav-pills nav-stacked">
                <li class="active"><a href="#" class="tab-link" id="overview"><span class="badge">${listUser?.size()}</span> Members</a></li>
                <li><a href="#" class="tab-link" id="clients"><span class="badge">${listEmail?.size()}</span> Invited</a></li>
              </ul>
            </div>
            <div id="dashboard_tabs" class="col-xs-12 col-sm-10">
                <!--Start Dashboard Tab 1-->
              <div id="dashboard-overview" class="row" style="visibility: visible; position: relative;">
                <div id="ow-marketplace" class="col-sm-12 col-md-12">
                  <g:form name="appUsers" useToken="true" uri="/${orgAliasId}/tbd" >
                    <div id="ow-setting1" class="pull-right">
                      <a href="javascript:$('#appUsers').attr('action', '${request.contextPath}/${folder.aliasId}/members');$('#appUsers').submit();" data-toggle="tooltip" data-placement="left" data-original-title="<g:message code="dashboard.member.remove" args='["Folder"]' />"><i class="fa fa-user-times"></i></a>
                    </div>
                    <h4 class="page-header">Members</h4>
                    <table id="ticker-table" class="table m-table table-bordered table-hover table-heading">
                      <thead>
                        <tr>
                          <th>Initials</th>
                          <th>Name</th>
                          <th>Role</th>
                          <th>Join Date</th>
                        </tr>
                      </thead>
                      <tbody>
                        <g:each status="i" in="${listUser}" var="objuser">
                          <tr>
                            <td class="m-ticker"><input name="selected" type="checkbox" value="${objuser.member.aliasId}"> <b>${objuser.member.initials?.encodeAsHTML()}</b><span></span></td>
                            <td class="td-graph">${objuser.member.name?.encodeAsHTML()}</td>
                            <td class="m-change">${objuser.memberRoles?.encodeAsHTML()}</td>
                            <td class="m-price">${objuser.createdDate}</td>
                          </tr>
                        </g:each>
                      </tbody>
                    </table>
                  </g:form>
                </div>

              </div>
              <!--End Dashboard Tab 1-->
              <!--Start Dashboard Tab 2-->
              <div id="dashboard-clients" class="row" style="visibility: hidden; position: absolute;">
                <div id="ow-marketplace" class="col-sm-12 col-md-12">
                  <g:form name="appEmails" useToken="true" uri="/${orgAliasId}/tbd" >
                    <div id="ow-setting1" class="pull-right">
                      <a href="javascript:$('#appEmails').attr('action', '${request.contextPath}/${folder.aliasId}/invited');$('#appEmails').submit();" data-toggle="tooltip" data-placement="left" data-original-title="<g:message code="dashboard.member.remove" args='["Folder"]' />"><i class="fa fa-user-times"></i></a>
                    </div>
                    <h4 class="page-header">Invited</h4>
                    <table id="ticker-table" class="table m-table table-bordered table-hover table-heading">
                      <thead>
                        <tr>
                          <th>Name</th>
                          <th>Email</th>
                          <th>Invited By</th>
                          <th>Invited Date</th>
                        </tr>
                      </thead>
                      <tbody>
                        <g:each status="i" in="${listEmail}" var="objemail">
                          <tr>
                            <td class="m-ticker"><input name="selected" type="checkbox" value="${objemail.memberId}"> <b>${objemail.invitedName.encodeAsHTML()}</b><span></span></td>
                            <td class="td-graph">${objemail.memberId}</td>
                            <td class="m-change">${objemail.invitedBy?.name}</td>
                            <td class="m-price">${objemail.createdDate}</td>
                          </tr>
                        </g:each>
                      </tbody>
                    </table>
                  </g:form>
                </div>

              </div>
              <!--End Dashboard Tab 2-->

            </div>
            <div class="clearfix"></div>
          </div>
          <!--End Dashboard 2 -->

          <div style="height: 40px;"></div>

        </div>
        <!--End Content-->

      </div>
    </div>

    <g:render template="/layouts/modal_invite_foldermember" model="[]" />
  <!-- script references -->
  <content tag="javascript">
    <script type="text/javascript" charset="utf-8">
      $(document).ready(function() {
      // enable tooltips
      $('[data-toggle="tooltip"]').tooltip();

      // Make all JS-activity for dashboard
      $('#content').on('click', 'a.tab-link', function (e) {
      e.preventDefault();
      $('div#dashboard_tabs').find('div[id^=dashboard]').each(function () {
      $(this).css('visibility', 'hidden').css('position', 'absolute');
      });
      var attr = $(this).attr('id');
      $('#' + 'dashboard-' + attr).css('visibility', 'visible').css('position', 'relative');
      $(this).closest('.nav').find('li').removeClass('active');
      $(this).closest('li').addClass('active');
      });
      });
    </script>
  </content>
</body>
</html>
