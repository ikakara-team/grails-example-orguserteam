<header class="navbar">
  <div class="container-fluid expanded-panel">
    <div class="row">
      <div id="logo" class="col-xs-12 col-sm-3 col-md-2">
        <a href="${request.contextPath}/">Example OUT</a>
      </div>
      <div id="top-panel" class="col-xs-12 col-sm-9 col-md-10">
        <div class="row">
          <div class="col-xs-12 top-panel-right">
            <ul class="nav navbar-nav pull-right panel-menu">
              <g:render template="/layouts/navpart_loggedin"  model="[]"/>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>