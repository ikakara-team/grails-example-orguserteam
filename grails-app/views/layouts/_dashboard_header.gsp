<header class="navbar">
  <div class="container-fluid expanded-panel">
    <div class="row">
      <div id="logo" class="col-xs-12 col-sm-3 col-md-2">
        <a href="${request.contextPath}/">Example OUT</a>
      </div>
      <div id="top-panel" class="col-xs-12 col-sm-9 col-md-10">
        <div class="row">
          <div class="col-xs-7 col-sm-7 col-md-8">
            <a href="#" class="show-sidebar">
              <i class="fa fa-bars"></i>
            </a>
            <g:if test="${org || folder}">
              <g:render template="/layouts/header_group_dropdown"  model="['org': org, 'folder': folder, 'org_path': org_path, 'folder_path': folder_path]"/>
            </g:if>
            <g:else>
              <ul class="nav navbar-nav panel-menu" style="padding-left: 2em;">
                <g:render template="/layouts/navpart_addorgfolder"  model="[]"/>
              </ul>
            </g:else>
          </div>
          <div class="col-xs-5 col-sm-5 col-md-4 top-panel-right">
            <ul class="nav navbar-nav pull-right panel-menu">
              <g:render template="/layouts/navpart_loggedin"  model="[]"/>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>