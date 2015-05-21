<sec:ifLoggedIn>
  <li class="dropdown fill-width">
    <a href="#" class="dropdown-toggle account" data-toggle="dropdown">
      <div class="avatar">
        <i class="fa fa-plus-square-o"></i>
      </div>
    </a>
    <ul class="dropdown-menu">
      <li><a data-toggle="modal" href="#addNewFolderModal"><g:message code="dashboard.newfolder" /> <p><g:message code="dashboard.newfolder.help" /></p></a></li>
      <li><a data-toggle="modal" href="#addNewOrgModal"><g:message code="dashboard.neworg" /> <p><g:message code="dashboard.neworg.help" /></p></a></li>
    </ul>
    <!-- /.dropdown-messages -->
  </li>
</sec:ifLoggedIn>