package ikakara.exampleout.web.app

import grails.plugin.springsecurity.annotation.Secured

import ikakara.awsinstance.command.EmailCommand

import ikakara.orguserteam.dao.dynamo.IdOrg
import ikakara.orguserteam.dao.dynamo.IdFolder
import ikakara.orguserteam.dao.dynamo.IdUser
import ikakara.orguserteam.dao.dynamo.IdEmail
import ikakara.orguserteam.dao.dynamo.IdUserOrg
import ikakara.orguserteam.dao.dynamo.IdEmailOrg
import ikakara.orguserteam.dao.dynamo.IdUserFolder
import ikakara.orguserteam.dao.dynamo.IdEmailFolder
import ikakara.orguserteam.web.app.ABaseOrgController

@Secured(['ROLE_USER'])
class DashboardOrgController extends ABaseOrgController {
  def springSecurityService
  def userDetailsService
  def emailService

  static allowedMethods = [
    profile: 'GET', updateOrgProfile: 'PUT', // org profile
    deleteOrg: 'DELETE', // org
    members: 'GET', inviteOrg: 'POST', orgInvitedRemove: 'DELETE', orgMembersRemove: 'DELETE', // org members
    orgFolders: 'GET', saveFolder: 'POST', // folders
  ]

  String getOrgSlugId() {
    return params.id
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

  def profile() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user)

    render view: 'org_profile', model:[org_path: 'profile', org: org, listFolder: listFolder]
  }

  def members() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def listUser = orgUserTeamService.listUser(org)
    def listEmail = orgUserTeamService.listEmail(org)

    render view: 'org_members', model:[org_path: 'members', org: org, listUser: listUser, listEmail: listEmail]
  }

  def inviteOrg() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def emailcmd = new EmailCommand().withTo(params.email)
    if(emailcmd.toValid()) {
      def email = orgUserTeamService.email(params.email, false)
      if(!email) {
        email = orgUserTeamService.createEmail(params.email)
      }

      def added = orgUserTeamService.addEmailToGroup(user, params.name, email, org)
      if(added) {
        def joinName = "organization ${org.name}"
        def joinUrl = "${grailsApplication.config.grails.secureServerURL}/welcome"
        emailService.sendInvitation(emailcmd, params.name, joinName, joinUrl, user.name)

        flash.message = "Invitation sent to ${emailcmd.to}"
      }
    }

    redirect(uri: "/${org.aliasId}/members")
  }

  def orgMembersRemove() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def selected = params.selected

    if(selected) {
      if(selected instanceof String) {
        selected = [params.selected]
      }

      selected.each {
        def member = orgUserTeamService.findIdObjBySlugId(it)
        // TBD: insure we leave one owner
        new IdUserOrg().withMember(member).withGroup(org).delete()
      }

    } else {
      flash.message = "Please select a member to remove"
    }

    redirect (uri: "/${org?.aliasId}/members")
  }

  def orgInvitedRemove() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def selected = params.selected

    if(selected) {
      if(selected instanceof String) {
        selected = [params.selected]
      }

      selected.each {
        def email = orgUserTeamService.email(it)
        new IdEmailOrg().withMember(email).withGroup(org).delete()
      }

    } else {
      flash.message = "Please select an invited to remove"
    }

    redirect (uri: "/${org?.aliasId}/members")
  }

  def orgFolders() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user, IdUserOrg.FOLDER_VISIBLE)

    render view: 'org_folders', model:[org_path: 'folders', org: org, listFolder: listFolder, user: user]
  }

  def saveFolder() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    IdFolder folderInstance = orgUserTeamService.createFolder(user, params.name, params.int('privacy'), org)
    if(!folderInstance) {
      flash.message = "Failed to create: ${params.name}"
      redirect uri: '/my-memberships'
    } else {
      request.withFormat {
        form multipartForm {
          flash.message = message(code: 'default.created.message', args: [message(code: 'IdFolder.label', default: 'IdFolder'), folderInstance.aliasId])
          redirect uri: "/${folderInstance.aliasId}/profile"
        }
      '*' { respond folderInstance, [status: CREATED] }
      }
    }
  }

  def deleteOrg() { // deleteOrg
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    // TBD - we should only allow owners to delete orgs

    if(org.hasMember(user)) {
      orgUserTeamService.deleteOrg(org)
      flash.message = message(code: 'default.deleted.message', args: [message(code: 'IdOrg.label', default: 'IdOrg'), org.aliasId])
      redirect (uri: "/my-memberships")
    } else {
      flash.message = "Must be owner to delete organization"
      redirect(uri: "/${org.aliasId}/profile")
    }
  }

  def updateOrgProfile() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)

    // TBD - we should check to see if user has proper rights

    if(org.hasMember(user)) {
      def corg = orgUserTeamService.updateOrg(org, params.name, params.description, params.website, params.idname, params.int('visibility'))
      if(!corg) {
        flash.message = "Failed to update: ${params.name}"
      }
    } else {
      flash.message = "Must be owner/admin to update organization"
    }

    redirect(uri: "/${org.aliasId}/profile")
  }

}
