<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Videos</title>
  <asset:stylesheet src="fileinput.css"/>
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
              <li><a href="#">Videos</a></li>
            </ol>
          </div>
        </div>
        <!--End Breadcrumb-->
        <!--Start Dashboard 1-->
        <g:if test="${flash.message}">
          <div class="row">
            <div class="col-xs-12 page-feed">
              <div class="message" role="status">${flash.message}</div>
            </div>
          </div>
        </g:if>
        <div id="dashboard-header" class="row">
          <div class="col-xs-12">
            <h3>Upload Video:</h3>

            <form id="fileupload" href='${request.contextPath}/${folder.aliasId}/videos' method="POST" enctype="multipart/form-data">
              <input id="input-id" name='file_data' type="file" class="file">
            </form>
          </div>
        </div>
        <!--End Dashboard 1-->
        <!--Start Dashboard 2-->
        <g:if test="${listVideo}">
          <div class="row">
            <g:each status="i" in="${listVideo}" var="objvideo">
              <div align="center" class="col-xs-4 embed-responsive embed-responsive-16by9" style='padding: 10%;'>
                <video class="embed-responsive-item">
                  <source src='//${objvideo}' type=video/mp4>
                </video>
              </div>
            </g:each>
          </div>
        </g:if>
        <!--End Dashboard 2 -->
        <div style="height: 40px;"></div>
      </div>
      <!--End Content-->
    </div>
  </div>
<!-- script references -->
<content tag="javascript">
  <asset:javascript src="fileinput/fileinput.js"/>
  <script type="text/javascript" charset="utf-8">
    // http://plugins.krajee.com/file-input#ajax-uploads
    $("#input-id").fileinput({
    'allowedFileTypes':['video'],
    //'uploadUrl':'${request.contextPath}/${folder.aliasId}/videos',
    'maxFileSize': 20480
    });
  </script>
</content>
</body>
</html>
