<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
  <div class="box box-pricing">
    <div class="thumbnail">
      <script type="text/javascript" charset="utf-8">
        // Select a random thumbnail to display
        document.writeln(SelectRandomImage());
      </script>
      <div class="caption">
        <h4 class="text-center">${folder?.name?.encodeAsHTML()} <g:render template="/layouts/part_folder_privacy" model="['folder': folder]" /></h4>
        <p>${folder?.description?.encodeAsHTML()}</p>
        <p>${userRole ?: ''}</p>
        <p>${memberList?.size() ? 'Members: ' + memberList?.size() : ''}</p>
        <a href="${request.contextPath}/${folder?.aliasId}/videos" class="btn btn-primary">Enter Folder</a>
      </div>
    </div>
  </div>
</div>