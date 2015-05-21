<div class="modal" id="addNewOrgModal">
  <div class="devoops-modal">
    <div class="devoops-modal-inner">

      <g:form useToken="true"  uri="/my-orgs" method="POST" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title"><g:message code="dashboard.createorg" /></h4>
        </div>
        <div class="modal-body">

          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="${orgName}" placeholder="" maxlength="32">
          </div>
          <div class="form-group">
            <label for="description">Description (optional)</label>
            <input type="text" class="form-control" id="description" name="description" placeholder="" maxlength="128">
          </div>

        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Create</button>
          <a href="#" data-dismiss="modal" class="btn">Close</a>
        </div>
        <span id="helpBlock" class="help-block" style="margin: 0 1.5em 1.5em 1.5em;"><g:message code="dashboard.neworg.help" /></span>
      </g:form>

    </div>
  </div>
</div>

<div class="modal" id="addNewFolderModal">
  <div class="devoops-modal">
    <div class="devoops-modal-inner">

      <g:form useToken="true" uri="/my-folders" >
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <h4 class="modal-title"><g:message code="dashboard.createfolder" /></h4>
        </div>
        <div class="modal-body">

          <div class="form-group">
            <label for="name">Name</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="" maxlength="32">
          </div>
          <div class="form-group">
            <label for="neworg">Organization</label>
            <select class="form-control" name="id" id="neworg">
              <option value="">(none)</option>
            </select>
          </div>
          <div class="form-group">
            <div class="radio">
              <label style="padding-left:2em; line-height: 1.5em;">
                <input type="radio" name="privacy" id="newPrivate" value="10" checked>
                Private
                <i class="fa fa-circle-o small"></i>
                <div class="fa fa-lock" style="float:left; font-size:1.5em; padding-right:1em;"></div>
                <p style="font-size:.9em;"><g:message code="dashboard.folder.privacy.private" /></p>
              </label>
            </div>
            <div class="radio">
              <label style="padding-left:2em; line-height: 1.5em;">
                <input type="radio" name="privacy" id="newOrganization" value="1" disabled>
                Organization
                <i class="fa fa-circle-o small"></i>
                <div class="fa fa-group" style="float:left; font-size:1.5em; padding-right:.5em;"></div>
                <p id="neworg-desc"  style="font-size:.9em;"><g:message code="dashboard.folder.privacy.org.none" /></p>
              </label>
            </div>
            <div class="radio">
              <label style="padding-left:2em; line-height: 1.5em;">
                <input type="radio" name="privacy" id="newPublic" value="0">
                Public
                <i class="fa fa-circle-o small"></i>
                <div class="fa fa-globe" style="float:left; font-size:1.5em; padding-right:.5em;"></div>
                <p style="font-size:.9em;"><g:message code="dashboard.folder.privacy.public" /></p>
              </label>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Create</button>
          <a href="#" data-dismiss="modal" class="btn">Close</a>
        </div>
        <span id="helpBlock" class="help-block" style="margin: 0 1.5em 1.5em 1.5em;"><g:message code="dashboard.newfolder.help" /></span>
      </g:form>

    </div>
  </div>
</div>