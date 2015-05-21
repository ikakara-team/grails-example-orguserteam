<g:if test="${emailgroup instanceof ikakara.orguserteam.dao.dynamo.IdEmailOrg}">
  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
    <div class="box box-pricing">
      <div class="thumbnail">
        <div class="caption">
          <h4 class="text-center"><i class="fa fa-sitemap"></i> ${emailgroup.group?.name?.encodeAsHTML()}</h4>
          <p>${emailgroup.group?.description?.encodeAsHTML()}</p>
          <g:if test="${emailgroup.group.webUrl}">
            <p>Web site: <a href="" alt="${emailgroup.group.name?.encodeAsHTML()}">${emailgroup.group.webUrl?.encodeAsHTML()}</a></p>
            </g:if>
          <div class="row">
            <div class="col-xs-6 hideOverflow">
              <p>
                <b><g:message code="welcome.invited" /></b> <g:message code="welcome.daysago" args='["${emailgroup.createdDaysAgo}"]' /><br/>
                <b><g:message code="welcome.invited.by" /></b> ${emailgroup.invitedBy.name?.encodeAsHTML()}
              </p>
            </div>
            <div class="col-xs-6">
              <g:form useToken="true" uri="/my-invitations/${emailgroup.group.aliasId}" method="POST" >
                <button type="submit" class="btn btn-primary btn-block"><g:message code="welcome.joinorg" /></button>
              </g:form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</g:if>
<g:elseif test="${emailgroup instanceof ikakara.orguserteam.dao.dynamo.IdEmailFolder}">
  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
    <div class="box box-pricing">
      <div class="thumbnail">
        <script type="text/javascript" charset="utf-8">
          // Select a random thumbnail to display
          document.writeln(SelectRandomImage());
        </script>
        <div class="caption">
          <h4 class="text-center">${emailgroup.group?.name?.encodeAsHTML()} <g:render template="/layouts/part_folder_privacy" model="['folder': emailgroup.group]" /></h4>
          <p>${emailgroup.group?.description?.encodeAsHTML()}</p>
          <div class="row">
            <div class="col-xs-6 hideOverflow">
              <p>
                <b><g:message code="welcome.invited" /></b> <g:message code="welcome.daysago" args='["${emailgroup.createdDaysAgo}"]' /><br/>
                <b><g:message code="welcome.invited.by" /></b> ${emailgroup.invitedBy.name?.encodeAsHTML()}
              </p>
            </div>
            <div class="col-xs-6">
              <g:form useToken="true" uri="/my-invitations/${emailgroup.group.aliasId}" method="POST" >
                <button type="submit" class="btn btn-primary btn-block"><g:message code="welcome.joinfolder" /></button>
              </g:form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</g:elseif>
<g:else>
  println "${emailgroup.class}"
</g:else>