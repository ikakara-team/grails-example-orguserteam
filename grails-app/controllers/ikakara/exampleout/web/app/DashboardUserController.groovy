package ikakara.exampleout.web.app

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import com.userstore.auth.UserstoreDetailsService

import ikakara.orguserteam.dao.dynamo.IdOrg
import ikakara.orguserteam.dao.dynamo.IdFolder
import ikakara.orguserteam.web.app.ABaseUserController

@Secured(['ROLE_USER'])
class DashboardUserController extends ABaseUserController {
  static allowedMethods = [
    saveOrg: "POST", updateProfile: "PUT"
  ]

  def springSecurityService
  def userDetailsService

  String getOrgSlugId() {
    return null
  }

  String getFolderSlugId() {
    return null
  }

  String getUserEmail() {
    return springSecurityService.principal?.email
  }

  String getUserId(){
    return springSecurityService.principal?.id
  }

  def memberships() {
    def user = request.getAttribute(USER_KEY)
    def invitedGroup = request.getAttribute(INVITED_KEY)

    def listOrg = orgUserTeamService.listFolderByAccount(user, "My Folders");

    render view: 'memberships', model:[my_path: 'memberships', orgName: params.name, listOrg: listOrg, invitedGroup: invitedGroup]
  }

  def profile() {
    def user = request.getAttribute(USER_KEY)

    if(!orgUserTeamService.exist(user)) {
      def fullname = springSecurityService.principal.full_name
      def initials = springSecurityService.principal.initials_name
      def cuser = orgUserTeamService.createUser(user, fullname, initials, '', '')
      if(cuser) {
        user = cuser // if successful
      }
    }

    render view: 'profile', model:[my_path: 'profile', user: user]
  }

  def updateProfile() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)

    def cuser = orgUserTeamService.updateUser(user, params.name, params.initials, params.description, params.idname)
    if(cuser) {
      flash.message = "Successfully updated!"
    } else {
      flash.message = "Failed to update: ${params.name}"
    }

    redirect uri: '/my-profile'
  }

  def saveOrg() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)

    IdOrg orgInstance = orgUserTeamService.createOrg(user, params.name, params.description)
    if(!orgInstance) {
      flash.message = "Failed to create: ${params.name}"
      redirect uri: '/my-memberships'
    } else {
      flash.message = message(code: 'default.created.message', args: [message(code: 'dashboard.label.org', default: 'IdOrg'), orgInstance.aliasId])
      redirect uri: "/${orgInstance.aliasId}/profile"
    }
  }

}
