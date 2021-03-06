<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Profile</title>
    <g:javascript>

    </g:javascript>
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
                <li><a href="#">Profile</a></li>
              </ol>
            </div>
          </div>
          <!--End Breadcrumb-->
          <!--Start Dashboard 1-->
          <div id="dashboard-header" class="row">
            <div class="col-xs-8 col-sm-6">
              <h3>${folder.name} Profile</h3>
            </div>
            <!--div class="clearfix visible-xs"></div-->
            <div class="col-xs-4 col-sm-6 pull-right">
              <div class="btn-group pull-right">
                <g:form useToken="true" uri="/${folder.aliasId}/profile" method="DELETE" name="folderDelete"></g:form>
                  <a href='javascript:$("#folderDelete").submit();' class="btn btn-primary" onclick="return confirm('Are you sure that you want to delete this folder???')">
                    <i class="fa fa-folder"></i>
                    <span class="hidden-xs"><g:message code="dashboard.deletefolder" /></span>
                </a>
              </div>
            </div>
          </div>
          <!--End Dashboard 1-->

          <div class="row">
            <div class="col-xs-12 col-sm-8">
              <div class="box">
                <div class="box-header">
                  <div class="box-name">
                    <i class="fa fa-search"></i>
                    <span>${folder.name}</span>
                  </div>

                  <div class="no-move"></div>
                </div>
                <div class="box-content">
                  <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                  </g:if>
                  <g:form name="profileForm" class="form-horizontal" useToken="true" uri="/${folder?.aliasId}/profile" method="PUT" >
                    <fieldset>
                      <legend>Public Profile</legend>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Display Name</label>
                        <div class="col-sm-5">
                          <input type="text" class="form-control" name="name" value="${folder?.name}" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Id Name</label>
                        <div class="col-sm-5">
                          <input type="text" class="form-control" name="idname" value="${folder?.aliasId}" />
                          <small class="time">Id should be 8+ characters</small>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Organization</label>
                        <div class="col-sm-5">
                          <g:select name="orgId" id="editorg" class="form-control" from="${listOrg}" value="${org?.aliasId}" optionKey="aliasId" optionValue="name" noSelection="['':'(none)']"/>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Privacy</label>
                        <div class="col-sm-8">
                          <div class="radio">
                            <label style="padding-left:2em; line-height: 1.5em;">
                              <input type="radio" name="privacy" id="editPrivate" value="10" >
                              Private
                              <i class="fa fa-circle-o small"></i>
                              <div class="fa fa-lock" style="float:left; font-size:1.5em; padding-right:1em;"></div>
                              <p style="font-size:.9em;"><g:message code="dashboard.folder.privacy.private" /></p>
                            </label>
                          </div>
                          <div class="radio">
                            <label style="padding-left:2em; line-height: 1.5em;">
                              <input type="radio" name="privacy" id="editOrganization" value="1" disabled>
                              Organization
                              <i class="fa fa-circle-o small"></i>
                              <div class="fa fa-group" style="float:left; font-size:1.5em; padding-right:.5em;"></div>
                              <p id="editorg-desc" style="font-size:.9em;"><g:message code="dashboard.folder.privacy.org.none" /></p>
                            </label>
                          </div>
                          <div class="radio">
                            <label style="padding-left:2em; line-height: 1.5em;">
                              <input type="radio" name="privacy" id="editPublic" value="0" >
                              Public
                              <i class="fa fa-circle-o small"></i>
                              <div class="fa fa-globe" style="float:left; font-size:1.5em; padding-right:.5em;"></div>
                              <p style="font-size:.9em;"><g:message code="dashboard.folder.privacy.public" /></p>
                            </label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Description</label>
                        <div class="col-sm-8">
                          <textarea class="form-control" rows="5" name="description">${folder?.description}</textarea>
                        </div>
                      </div>
                    </fieldset>
                    <div class="form-group">
                      <div class="col-sm-9 col-sm-offset-3">
                        <button type="submit" class="btn btn-primary">Submit</button>
                      </div>
                    </div>
                  </g:form>
                </div>
              </div>
            </div>
          </div>

        </div>
        <!--End Content-->

      </div>
    </div>

  <!-- script references -->
  <content tag="javascript">
    <script type="text/javascript" charset="utf-8">
      $(document).ready(function() {
      // Add drag-n-drop feature to boxes
      WinMove();
      // Form validation
      FormValidator('#profileForm');
      });

      window.privacyPrivate = ${folder.isPrivacyPrivate()};
      window.privacyOrg = ${folder.isPrivacyOrg()};
      window.privacyPublic = ${folder.isPrivacyPublic()};
      window.orgname = '${org?.name}';
    </script>
    <asset:javascript src="profile_edit_folder.js"/>
  </content>
</body>
</html>
