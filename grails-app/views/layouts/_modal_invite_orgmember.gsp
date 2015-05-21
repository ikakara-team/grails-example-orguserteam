<div class="modal" id="inviteOrgMemberModal">
  <div class="devoops-modal">
    <div class="devoops-modal-inner">

      <g:form useToken="true" uri="/${org.aliasId}/invited" method="POST">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title"><g:message code="dashboard.invitemember.title" args='["${message(code: 'dashboard.label.org')}"]' /></h4>
        </div>
        <div class="modal-body">

          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="" maxlength="32">
          </div>
          <div class="form-group">
            <label for="description">Email</label>
            <input type="text" class="form-control" id="email" name="email" placeholder="" maxlength="128">
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Invite</button>
          <a href="#" data-dismiss="modal" class="btn">Close</a>
        </div>
        <span id="helpBlock" class="help-block" style="margin: 0 1.5em 1.5em 1.5em;"><g:message code="dashboard.neworg.help" /></span>
      </g:form>

    </div>
  </div>
</div>
