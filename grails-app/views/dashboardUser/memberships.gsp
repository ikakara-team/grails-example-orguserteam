<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Welcome</title>
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
                <li><a href="#">Memberships</a></li>
              </ol>
            </div>
          </div>
          <!--Start Dashboard 1-->
          <div id="dashboard-header" class="row">
            <div class="col-xs-8 col-sm-6">
              <h3>Memberships</h3>
            </div>
            <!--div class="clearfix visible-xs"></div-->
            <div class="col-xs-4 col-sm-6 pull-right">
              <div class="btn-group pull-right">
                <a  class="btn btn-primary" data-toggle="modal" href="#addNewFolderModal">
                  <i class="fa fa-folder"></i>
                  <span class="hidden-xs"><g:message code="dashboard.createfolder" /></span>
                </a>
                <a class="btn btn-primary" data-toggle="modal" href="#addNewOrgModal">
                  <i class="fa fa-sitemap"></i>
                  <span class="hidden-xs"><g:message code="dashboard.createorg" /></span>
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
          <% def myapps = listOrg[0]; %>
          <div class="wide">
            <div class="col-xs-4 col-sm-5 line"><hr></div>
            <div class="col-xs-4 col-sm-2 logo">${myapps.name?.encodeAsHTML()}</div>
            <div class="col-xs-4 col-sm-5 line"><hr></div>
          </div>
          <div class="row folder">
            <g:each status="j" in="${myapps.folderList}" var="folder">
              <g:render template="/layouts/part_folder" model="['folder': folder]" />
            </g:each>
          </div>
          <g:each status="i" in="${listOrg}" var="org">
            <% if(i != 0) { %>
            <div class="wide">
              <div class="col-xs-4 col-sm-5 line"><hr></div>
              <div class="col-xs-4 col-sm-2 logo">
                <a data-toggle="tooltip" data-placement="left" data-original-title="${org.description?.encodeAsHTML()}">${org.name?.encodeAsHTML()}</a>
                <g:if test="${org.aliasId}">
                  <p style="clear:both;"><a style="color:graytext; font-size:.6em;" href="${org.aliasId ? request.contextPath + '/' + org.aliasId + '/profile' : '#'}"> <i class="fa fa-info-circle"></i> View Profile</a></p>
                </g:if>
              </div>
              <div class="col-xs-4 col-sm-5 line"><hr></div>
            </div>
            <div class="row folder">
              <g:each status="j" in="${org.folderList}" var="folder">
                <g:render template="/layouts/part_folder" model="['folder': folder]" />
              </g:each>
            </div>
            <% } %>
          </g:each>
          <!-- -->
          <g:if test="${invitedGroup}">
            <div class="wide">
              <div class="col-xs-4 col-sm-5 line"><hr></div>
              <div class="col-xs-4 col-sm-2 logo">My Invitations</div>
              <div class="col-xs-4 col-sm-5 line"><hr></div>
            </div>
            <div class="row folder">
              <g:each status="i" in="${invitedGroup}" var="emailgroup">
                <g:render template="/layouts/part_email_group" model="['emailgroup': emailgroup]" />
              </g:each>
            </div>
          </g:if>
          <!-- -->
        </div>
        <!--End Content-->
      </div>
    </div>
    <!--End Container-->
  <!-- script references -->
  <content tag="javascript">
    <script type="text/javascript" charset="utf-8">
      $(function () {
      $('[data-toggle="tooltip"]').tooltip()
      })
    </script>
  </content>
</body>
</html>
