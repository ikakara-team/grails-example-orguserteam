"use strict";

// Required input
// window.text_privacy_org_none = '<g:message code="dashboard.folder.privacy.org.none" />';
// window.text_privacy_org_edit = '<g:message code="dashboard.folder.privacy.org" args="['editorg-name']" />';
// window.privacyPrivate = ${folder.isPrivacyPrivate()};
// window.privacyOrg = ${folder.isPrivacyOrg()};
// window.privacyPublic = ${folder.isPrivacyPublic()};
// window.orgname = '${org?.name}';

$(function () {
  // reset privacy
  $('#editPrivate').prop('checked', privacyPrivate);
  $('#editOrganization').prop('checked', privacyOrg);
  $('#editPublic').prop('checked', privacyPublic);

  if (orgname) {
    $('#editorg-desc').html(text_privacy_org_edit);
    $('#editorg-name').html(orgname);
    $('#editOrganization').prop('disabled', false);
  }

  // personalize radio buttons
  $('#editorg').on('change', function () {
    var selected = $('#editorg option:selected').val();
    var text = $('#editorg option:selected').text();
    if (selected === "") {
      $('#editorg-desc').html(text_privacy_org_none);
      $('#editOrganization').prop('disabled', true);
    } else {
      $('#editOrganization').prop('disabled', false);
      $('#editorg-desc').html(text_privacy_org_edit);
      $('#editorg-name').html(text);
    }
    // reset privacy
    $('#editPrivate').prop('checked', true);
    $('#editOrganization').prop('checked', false);
    $('#editPublic').prop('checked', false);
  });
});