<g:if test="${folder?.isPrivacyPrivate()}">
  <i class="fa fa-lock"></i>
</g:if>
<g:elseif test="${folder?.isPrivacyOrg()}">
  <i class="fa fa-group"></i>
</g:elseif>
<g:else>
  <i class="fa fa-globe"></i>
</g:else>