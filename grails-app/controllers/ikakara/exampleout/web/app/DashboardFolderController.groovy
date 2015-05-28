package ikakara.exampleout.web.app

import static org.springframework.http.HttpStatus.*
import grails.converters.JSON
import grails.converters.XML

import grails.plugin.springsecurity.annotation.Secured

import ikakara.awsinstance.command.EmailCommand
import ikakara.awsinstance.util.FileUtil

import ikakara.orguserteam.dao.dynamo.IdOrg
import ikakara.orguserteam.dao.dynamo.IdFolder
import ikakara.orguserteam.dao.dynamo.IdUser
import ikakara.orguserteam.dao.dynamo.IdEmail
import ikakara.orguserteam.dao.dynamo.IdUserOrg
import ikakara.orguserteam.dao.dynamo.IdEmailOrg
import ikakara.orguserteam.dao.dynamo.IdUserFolder
import ikakara.orguserteam.dao.dynamo.IdEmailFolder
import ikakara.orguserteam.web.app.ABaseFolderController

import ikakara.exampleout.command.VideoCommand

@Secured(['ROLE_USER'])
class DashboardFolderController extends ABaseFolderController {
  static allowedMethods = [
    folder_videos:'GET', upload_video: 'POST',
    deleteFolder: 'DELETE', // folder
    folder_profile: 'GET', updateFolderProfile: 'PUT', // folder profile
    folder_members: 'GET', inviteFolder: 'POST', folderInvitedRemove: 'DELETE', addFolderMember: 'PUT', folderMembersRemove: 'DELETE', // folder members
    process_video: 'POST',
  ]

  def springSecurityService
  def userDetailsService
  def emailService
  def storageService

  String getOrgSlugId() {
    return null
  }

  String getFolderSlugId() {
    return params.id
  }

  String getUserEmail() {
    return springSecurityService.principal?.email
  }

  String getUserId(){
    return springSecurityService.principal?.id
  }

  def folder_videos() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user)

    def listVideo = storageService.list(folder)

    render view: 'folder_videos', model:[org_path: 'folders', folder_path: 'videos', org: org, folder: folder, listFolder: listFolder, listVideo: listVideo]
  }

  def upload_video(VideoCommand videoCommand) {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    videoCommand.uploadFile = request.getFile('file_data');
    if(!videoCommand.uploadFile) {
      flash.message = "Video upload failed. Invalid file. Please try again."
    } else if (!videoCommand.validate(["uploadFile"]) || videoCommand.hasErrors()) { // validate uploadFile
      flash.message = videoCommand.errors
    } else {
      // rename file - tempfiles are placed in
      // windows: C:\Users\[user]\AppData\Local\Temp
      // linux: /usr/share/tomcat7/temp
      videoCommand.tempFilename = FileUtil.generateRandomFileName("VID")
      videoCommand.tempFile = File.createTempFile(videoCommand.tempFilename, ".${videoCommand.videoExtension}")
      videoCommand.uploadFile.transferTo(videoCommand.tempFile)

      storageService.save(folder, videoCommand)

      videoCommand.cleanup()
    }

    redirect(uri: "/${folder.aliasId}/videos")
  }

  def delete_video(VideoCommand videoCommand) {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    videoCommand.withVideoFilename(params.fileName)
    storageService.delete(folder, videoCommand)

    redirect(uri: "/${folder.aliasId}/videos")
  }

  def do_video(VideoCommand videoCommand) {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user)
    def listVideo = storageService.list(folder)?.collect { [name: (it.split('/videos/')[1]), url: it] }

    def fileName = params.fileName

    render view: 'do_video', model:[org_path: 'folders', folder_path: 'videos', org: org, folder: folder, listFolder: listFolder, listVideo: listVideo, fileName: fileName]
  }

  def process_video() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def fileName = params.fileName

    def data
    if(params.data) {
      data = JSON.parse(params.data);
    }

    println '--------TO DO--------' + data

    def ret = [status: CREATED.ordinal(), fileName: fileName, data: data]

    render ret as JSON
  }

  def folder_profile() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user)

    List list = orgUserTeamService.listOrg(user)
    def listOrg = list?.collect { IdUserOrg it -> it.group }

    render view: 'folder_profile', model:[org_path: 'folders', folder_path: 'profile', org: org, folder: folder, listFolder: listFolder, listOrg: listOrg]
  }

  def updateFolderProfile() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    // TBD - we should only allow admins to update profile

    if(folder.hasMember(user)) {
      def neworg
      if(params.orgId) {
        // validate that the slug is for an org
        neworg = IdOrg.fromSlug(params.orgId)
      }

      def account = neworg ?: user
      orgUserTeamService.updateFolderOwner(folder, account)
      def capp = orgUserTeamService.updateFolder(folder, params.name, params.int('privacy'), params.description, params.idname)
      if(!capp) {
        flash.message = "Failed to update: ${params.name}"
      }
    } else {
      flash.message = "Must be admin to update folder"
    }

    redirect(uri: "/${folder.aliasId}/profile")
  }

  def deleteFolder() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    // TBD - we should only allow admins to delete apps

    if(folder.hasMember(user)) {
      // TBD - we need to delete S3 folder

      orgUserTeamService.deleteFolder(folder)
      flash.message = message(code: 'default.deleted.message', args: [message(code: 'IdFolder.label', default: 'IdFolder'), folder.aliasId])
      if(org) {
        redirect (uri: "/${org.aliasId}/folders")
      } else {
        redirect (uri: "/my-memberships")
      }
    } else {
      flash.message = "Must be admin to delete application"
      redirect(uri: "/${folder.aliasId}/profile")
    }
  }

  def folder_members() {
    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def listFolder = orgUserTeamService.listFolderVisible(org, user)

    def listUser = orgUserTeamService.listUser(folder)
    def listEmail = orgUserTeamService.listEmail(folder)
    // find all the members in org, but not already members of folder
    def listOrgUser
    if(org) {
      listOrgUser = orgUserTeamService.listUser(org)
    }

    def listAdd = listOrgUser.findAll{ !(it.member.id in listUser.collect{it.member.id}) && it.memberAliasId }

    render view: 'folder_members', model:[org_path: 'folders', folder_path: 'members', org: org, folder: folder, listFolder: listFolder, listUser: listUser, listEmail: listEmail, listAdd: listAdd]
  }

  def inviteFolder() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def emailcmd = new EmailCommand().withTo(params.email)
    if(emailcmd.toValid()) {
      def email = orgUserTeamService.email(params.email, false)
      if(!email) {
        email = orgUserTeamService.createEmail(params.email)
      }

      def added = orgUserTeamService.addEmailToGroup(user, params.name, email, folder)
      if(added) {
        def joinName = "application ${folder.name}"
        def joinUrl = "${grailsApplication.config.grails.secureServerURL}/welcome"
        emailService.sendInvitation(emailcmd, params.name, joinName, joinUrl, user.name)

        flash.message = "Invitation sent to ${emailcmd.to}"
      }
    }

    redirect (uri: "/${folder.aliasId}/members")
  }

  def addFolderMember() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def memberId = params.memberId
    def roles = params.role

    if(memberId) {
      if(memberId instanceof String) {
        memberId = [params.memberId]
      }

      memberId.each {
        def member = orgUserTeamService.findIdObjBySlugId(it)
        def added = orgUserTeamService.addUserToGroup(user, member, folder, roles)
        if(added) {
          log.debug "Successfully added member ${member.name}"
        } else {
          log.warn "Failed to add member ${member.name}"
        }
      }

    } else {
      flash.message = "Please select a member to add"
    }

    redirect (uri: "/${folder.aliasId}/members")
  }


  def folderMembersRemove() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def selected = params.selected

    if(selected) {
      if(selected instanceof String) {
        selected = [params.selected]
      }

      selected.each {
        def member = orgUserTeamService.findIdObjBySlugId(it)
        new IdUserFolder().withMember(member).withGroup(folder).delete()
      }

    } else {
      flash.message = "Please select a member to remove"
    }

    redirect (uri: "/${folder.aliasId}/members")
  }

  def folderInvitedRemove() {
    withForm {
      // good request
    }.invalidToken {
      // bad request
      return
    }

    def user = request.getAttribute(USER_KEY)
    def org = request.getAttribute(ORG_KEY)
    def folder = request.getAttribute(FOLDER_KEY)

    def selected = params.selected

    if(selected) {
      if(selected instanceof String) {
        selected = [params.selected]
      }

      selected.each {
        def email = orgUserTeamService.email(it)
        new IdEmailFolder().withMember(email).withGroup(folder).delete()
      }

    } else {
      flash.message = "Please select an invited to remove"
    }


    redirect (uri: "/${folder.aliasId}/members")
  }

}
