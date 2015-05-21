<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>My Profile</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body>
    <!--Start Container-->
    <div id="main" class="container-fluid">
      <div class="row">
        <div id="sidebar-left" class="col-xs-2 col-sm-2">
          <g:render template="/layouts/sidebar_my_menu" model="['my_path': my_path]" />
        </div>
        <!--Start Content-->
        <div id="content" class="col-xs-12 col-sm-10">
          <div class="row">
            <div id="breadcrumb" class="col-md-12">
              <ol class="breadcrumb">
                <li><a href="#">My Account</a></li>
                <li><a href="#">Profile</a></li>
              </ol>
            </div>
          </div>
          <div id="dashboard-header" class="row">
            <div class="col-xs-12">
              <h3><g:message code="dashboard.profile.heading" /></h3>
            </div>
          </div>
          <div class="row">
            <div class="col-xs-12 col-sm-8">
              <div class="box">
                <div class="box-header">
                  <div class="box-name">
                    <i class="fa fa-search"></i>
                    <span>Profile</span>
                  </div>

                  <div class="no-move"></div>
                </div>
                <div class="box-content">
                  <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                  </g:if>
                  <g:form name="profileForm" class="form-horizontal" useToken="true" uri="/my-profile" method="PUT" >
                    <fieldset>
                      <legend>Public Profile</legend>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Display Name</label>
                        <div class="col-sm-5">
                          <input type="text" class="form-control" name="name" value="${user?.name}" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Id Name</label>
                        <div class="col-sm-5">
                          <input type="text" class="form-control" name="idname" value="${user?.aliasId}" />
                          <small class="time">Id should be 8+ characters</small>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Initials</label>
                        <div class="col-sm-3">
                          <input type="text" class="form-control" name="initials" value="${user?.initials}" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Bio</label>
                        <div class="col-sm-8">
                          <textarea class="form-control" rows="5" name="description">${user?.description}</textarea>
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

<!--End Content-->
        </div>
      </div>
      <!--End Container-->
      <!-- script references -->
      <content tag="javascript">
        <script type="text/javascript" charset="utf-8">
          $(document).ready(function() {
          // Add drag-n-drop feature to boxes
          WinMove();
          // Form validation
          FormValidator('#profileForm');
          });
        </script>
      </content>
  </body>
</html>
