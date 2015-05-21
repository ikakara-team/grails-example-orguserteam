"use strict";

function isEqual(str1, str2) {
  if (str1 === undefined || str2 === undefined) {
    return false;
  }
  return str1 < str2 ? false : (str1 > str2 ? false : true);
}
// required input
// window.appContext = '${request.contextPath}';
// window.text_privacy_org_none = '<g:message code="dashboard.folder.privacy.org.none" />';
// window.text_privacy_org_new  = '<g:message code="dashboard.folder.privacy.org" args="['neworg-name']" />';

// on page load
$(function () {
  // personalize radio buttons
  $('#neworg').on('change', function () {
    var selected = $('#neworg option:selected').val();
    var text = $('#neworg option:selected').text();
    if (selected === "") {
      $('#neworg-desc').html(text_privacy_org_none);
      $('#newOrganization').prop('disabled', true);
    } else {
      $('#newOrganization').prop('disabled', false);
      $('#neworg-desc').html(text_privacy_org_new);
      $('#neworg-name').html(text);
    }
    // reset privacy
    $('#newPrivate').prop('checked', true);
    $('#newOrganization').prop('checked', false);
    $('#newPublic').prop('checked', false);
  });
});

// populate select options
$('#addNewFolderModal').on('shown.bs.modal', function (e) {
  //get data-id attribute of the clicked element
  var orgId = $(e.relatedTarget).data('orgid');
  // reset privacy
  $('#neworg-desc').html(text_privacy_org_none);
  $('#newPrivate').prop('checked', true);
  $('#newOrganization').prop('checked', false);
  $('#newPublic').prop('checked', false);
  // reset select option
  if (orgId) {
    $('#neworg').html('<option value=\"\">(none)</option>');
    $('#newOrganization').prop('disabled', false);
  } else {
    $('#neworg').html('<option value=\"\" selected=\"selected\">(none)</option>');
    $('#newOrganization').prop('disabled', true);
  }

  // get the select options ...
  $.ajax({
    url: appContext + "/my-orgs",
    type: 'GET',
    cache: false
  }).done(function (html) {
    $.each(html.data, function (index, value) {
      var bool = isEqual(orgId, value.aliasId);
      //console.log('orgId:' + orgId + ' aliasId:' + value.aliasId + ' compare:' + bool);
      if (bool) {
        $('#neworg').append($('<option/>', {
          value: value.aliasId,
          text: value.name,
          selected: 'selected'
        }));
        $('#neworg-desc').html(text_privacy_org_new);
        $('#neworg-name').html(value.name);
      } else {
        $('#neworg').append($('<option/>', {
          value: value.aliasId,
          text: value.name
        }));
      }
    });
  });

})