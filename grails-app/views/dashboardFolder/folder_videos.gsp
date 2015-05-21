<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Videos</title>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/helpers/jquery.fancybox-buttons.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/helpers/jquery.fancybox-thumbs.css">

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
        <div class="row">
          <div class="col-xs-12">
            <div class="box">
              <div class="box-header">
                <div class="box-name">
                  <i class="fa fa-picture-o"></i>
                  <span>Video Gallery</span>
                </div>
                <div class="no-move"></div>
              </div>
              <div id="simple_gallery" class="box-content">
                <g:if test="${listVideo}">
                  <g:each status="i" in="${listVideo}" var="objvideo">
                    <a class="fancybox fancybox.iframe" rel="gallery1" href="//${objvideo}">
                      <video>
                        <source src='//${objvideo}' type=video/mp4>
                      </video>
                    </a>
                  </g:each>
                </g:if>
              </div>
            </div>
          </div>
        </div>


        <!--End Dashboard 2 -->
        <div style="height: 40px;"></div>
      </div>
      <!--End Content-->
    </div>
  </div>
<!-- script references -->
<content tag="javascript">
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.12/jquery.mousewheel.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.pack.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/helpers/jquery.fancybox-buttons.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/helpers/jquery.fancybox-media.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/helpers/jquery.fancybox-thumbs.js"></script>

  <asset:javascript src="fileinput/fileinput.js"/>
  <script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
    $('.fancybox').fancybox({
    openEffect	: 'none',
    closeEffect	: 'none'
    });
    });

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
