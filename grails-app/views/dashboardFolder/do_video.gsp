<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="dashboard"/>
    <title>Videos</title>
  <asset:stylesheet src="player/do_video.css"/>
  <style type="text/css">

  </style>
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
              <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                  <span class="hidden-xs">${fileName}</span>
                  <i class="fa fa-angle-down pull-right"></i>
                </a>
                <ul class="dropdown-menu dropdown-messages">
                  <g:each status="i" in="${listVideo}" var="objvideo">
                    <g:if test="${fileName != objvideo.name}">
                      <li><a href="${request.contextPath}/${folder.aliasId}/videos/${objvideo.name}" title="${objvideo.name}">${objvideo.name}</a></li>
                      </g:if>
                    </g:each>
                </ul>
              </li>
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
        <div id="dashboard-header" class="row vertical-align">
          <div class="col-xs-3">
            <h3>Loading: <span id="loadingStatus">0%</span></h3>
            <div class="videoTime">
              <span id="videoCurrentTime">0</span>/<span id="videoDuration">0</span> (<span id="videoFrame">0</span>)
            </div>
          </div>
          <div class="col-xs-6">
            <div class="videoControls">
              <a href="#" onclick="m.setCurrentTime(0.0);" data-toggle="tooltip" title="Rewind to beginning"><span class="fa fa-circle"></span></a>
              <a href="#" onclick="m.pause();" data-toggle="tooltip" title="Pause"><span class="fa fa-pause"></span></a>
              <a href="#" onclick="m.adjustPlaybackRate(0.5); m.play();" data-toggle="tooltip" title="Play 0.5 rate"><span class="fa fa-step-forward"></span></a>
              <a href="#" onclick="m.adjustPlaybackRate(1.0); m.play();" data-toggle="tooltip" title="Play 1.0 rate"><span class="fa fa-play"></span></a>
              <a href="#" onclick="m.adjustPlaybackRate(1.5); m.play();" data-toggle="tooltip" title="Play 1.5 rate"><span class="fa fa-fast-forward"></span></a>
              <a href="#" onclick="m.decrementCurrentTime(.2666664);" data-toggle="tooltip" title="Back 16 frame"><span class="fa fa-chevron-left"></span></a>
              <a href="#" onclick="m.decrementCurrentTime(.1333332);" data-toggle="tooltip" title="Back 8 frame"><span class="fa fa-backward"></span></a>
              <a href="#" onclick="m.decrementCurrentTime(.0666666);" data-toggle="tooltip" title="Back 4 frame"><span class="fa fa-caret-left"></span></a>
              <a href="#" onclick="m.decrementCurrentTime(.0333333);" data-toggle="tooltip" title="Back 2 frame"><span class="fa fa-angle-double-left"></span></a>
              <a href="#" onclick="m.decrementCurrentTime(.0166666);" data-toggle="tooltip" title="Back 1 frame"><span class="fa fa-angle-left"></span></a>
              <a href="#" onclick="m.incrementCurrentTime(.0166666);" data-toggle="tooltip" title="Forward 1 frame"><span class="fa fa-angle-right"></span></a>
              <a href="#" onclick="m.incrementCurrentTime(.0333333);" data-toggle="tooltip" title="Forward 2 frame"><span class="fa fa-angle-double-right"></span></a>
              <a href="#" onclick="m.incrementCurrentTime(.0666666);" data-toggle="tooltip" title="Forward 4 frame"><span class="fa fa-caret-right"></span></a>
              <a href="#" onclick="m.incrementCurrentTime(.1333332);" data-toggle="tooltip" title="Forward 8 frame"><span class="fa fa-forward"></span></a>
              <a href="#" onclick="m.incrementCurrentTime(.2666664);" data-toggle="tooltip" title="Forward 16 frame"><span class="fa fa-chevron-right"></span></a>
            </div>
          </div>
          <div class="col-xs-3">
            <div class="videoControls">
              <a href="#" onclick="s.clearAll();" data-toggle="tooltip" title="Clear all objects"><span class="fa fa-recycle"></span></a>
              <a href="#" onclick="s.createShape(80, 150, 60, 30, 'rgba(127, 255, 212, .5)');" data-toggle="tooltip" title="Create box"><span class="fa fa-plus-square" style="color: rgb(127, 255, 212);"></span></a>
              <a href="#" onclick="s.createShape(80, 150, 60, 30, 'rgba(245, 222, 179, .7');" data-toggle="tooltip" title="Create box"><span class="fa fa-plus-square" style="color: rgb(245, 222, 179);"></span></a>
              <a href="#" onclick="s.recordSelectionShape();" data-toggle="tooltip" title="Bind marked object to time/frame"><span class="fa fa-clock-o"></span></a>
              <a href="#" onclick="uploadMarkedObjects('${request.contextPath}/${folder.aliasId}/videos-process/${fileName}', s);" data-toggle="tooltip" title="Upload to start processing marked objects"><span class="fa fa-cloud-upload"></span></a>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-xs-9 table-responsive no-scroll-bars">
            <table class="table table-hover table-bordered table-condensed">
              <caption class="text-left">Mark Objects: Double click to create mark.<br/>Select mark to move/resize; right click to remove; double click to bind <span class="fa fa-clock-o"></span> time.</caption>
              <tbody>
                <tr>
                  <td class="canvas">
                    <canvas id="canvasOne" width="900" height="540">
                      Your browser does not support HTML5 Canvas.
                    </canvas>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="col-xs-3 table-responsive">
            <table class="table table-hover table-bordered table-condensed">
              <caption class="text-left">Marked Objects: <span id="markedCount" class="badge">0</span><br/><span class="fa fa-cloud-upload"></span> Upload to start processing.</caption>
              <tbody id='markedObjects'></tbody>
            </table>
          </div>
        </div>
        <!--End Dashboard 1-->
        <!--Start Dashboard 2-->
        <div class="row">
          <div class="col-xs-12 table-responsive">
            <table class="table table-hover table-bordered table-condensed">
              <caption>Media Events</caption>
              <tbody id='events'></tbody>
            </table>
            <table class="table table-hover table-bordered table-condensed">
              <caption>Media Properties</caption>
              <tbody id='properties'></tbody>
            </table>
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
  <asset:javascript src="player/media.js"/>
  <asset:javascript src="player/video_draw.js"/>
  <asset:javascript src="player/do_video.js"/>
  <script type="text/javascript" charset="utf-8">
    var s = new CanvasState(document.getElementById('canvasOne')).withUpdateSeeked();
    s.switch("//${listVideo.find { it.name == fileName }.url}");
    s.initShapesUpdate('markedObjects', 'markedCount', 's');

    var d = new DoVideo(s.videoElement);
    var m = d.media;

    $(function () {
    $('[data-toggle="tooltip"]').tooltip()
    })
  </script>
</content>
</body>
</html>
