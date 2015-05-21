<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>My Settings</title>
    <style type='text/css' media='screen'>
    </style>
  </head>
  <body>
    <!--Start Container-->
    <div id="main" class="container-fluid">
      <div class="row">
        <div id="sidebar-left" class="col-xs-2 col-sm-2">
          <g:render template="/layouts/sidebar_my_menu" model="['my_path': 'settings']" />
        </div>
        <!--Start Content-->
        <div id="content" class="col-xs-12 col-sm-10">
          <div class="row">
            <div id="breadcrumb" class="col-md-12">
              <ol class="breadcrumb">
                <li><a href="#">My Account</a></li>
                <li><a href="#">Settings</a></li>
              </ol>
            </div>
          </div>
          <div id="dashboard-header" class="row">
            <div class="col-xs-12">
              <h3><g:message code="dashboard.settings.heading" /></h3>
            </div>
          </div>
          <div class="row">
            <div class="col-xs-12 col-sm-8">
              <div class="box">
                <div class="box-header">
                  <div class="box-name">
                    <i class="fa fa-search"></i>
                    <span>Account Settings</span>
                  </div>

                  <div class="no-move"></div>
                </div>
                <div class="box-content">
                  <g:if test="${form == 'settings' && flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                  </g:if>
                  <g:form name="accountForm" class="form-horizontal" useToken="true"  uri="/my-settings" method="PUT" >

                    <fieldset>
                      <legend>Change Details</legend>

                      <div class="form-group">
                        <label class="col-sm-3 control-label">First Name</label>
                        <div class="col-sm-5">
                          <input type="hidden" name="prev_first_name" value="${auth?.first_name}" />
                          <input type="text" class="form-control" name="first_name" value="${auth?.first_name}" />
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label">Last Name</label>
                        <div class="col-sm-5">
                          <input type="hidden" name="prev_last_name" value="${auth?.last_name}" />
                          <input type="text" class="form-control" name="last_name" value="${auth?.last_name}" />
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label">Username</label>
                        <div class="col-sm-5">
                          <input type="hidden" name="prev_username" value="${auth?.username}" />
                          <input type="text" class="form-control" name="username" value="${auth?.username}" />
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label">Email address</label>
                        <div class="col-sm-5">
                          <input type="hidden" name="prev_email" value="${auth?.email}" />
                          <input type="text" class="form-control" name="email" value="${auth?.email}" />
                          <span style="font-size: .75em;">**<g:message code="springSecurityUserstore.account.settings.warning" /></span>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label">Verify Password</label>
                        <div class="col-sm-5">
                          <input type="password" class="form-control" name="verifyPassword" />
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

          <div class="row">
            <div class="col-xs-12 col-sm-8">
              <div class="box">
                <div class="box-header">
                  <div class="box-name">
                    <i class="fa fa-search"></i>
                    <span>Account Password</span>
                  </div>

                  <div class="no-move"></div>
                </div>
                <div class="box-content">
                  <g:if test="${form == 'password' && flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                  </g:if>
                  <g:form name="passwordForm" class="form-horizontal" useToken="true"  uri="/my-settings" method="POST" >

                    <fieldset>
                      <legend>Change Password</legend>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Existing Password</label>
                        <div class="col-sm-5">
                          <input type="password" class="form-control" name="verifyPassword" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">New Password</label>
                        <div class="col-sm-5">
                          <input type="password" class="form-control" name="password" />
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-3 control-label">Retype password</label>
                        <div class="col-sm-5">
                          <input type="password" class="form-control" name="confirmPassword" />
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
    <!--End Container-->

  <!-- script references -->
  <content tag="javascript">
    <script type="text/javascript" charset="utf-8">
      $(document).ready(function() {
      // Add drag-n-drop feature to boxes
      WinMove();
      // Form validation
      FormValidator('#accountForm');
      FormValidator('#passwordForm');
      });
    </script>
  </content>

</body>
</html>
