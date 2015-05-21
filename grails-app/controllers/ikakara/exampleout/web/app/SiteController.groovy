package ikakara.exampleout.web.app

import grails.plugin.springsecurity.annotation.Secured

import ikakara.orguserteam.dao.dynamo.IdFolder
import ikakara.orguserteam.dao.dynamo.IdOrg
import ikakara.orguserteam.dao.dynamo.IdUser

class SiteController {

  def springSecurityService
  def orgUserTeamService

  @Secured(['permitAll'])
  def index() { }

  @Secured(['ROLE_USER'])
  def forward() {
    def id = params.id
    if(id) {
      def idObj = orgUserTeamService.findIdObjBySlugId(id)
      if(!idObj) {
      } else if(idObj instanceof IdFolder) {
        switch(request.method) {
        case 'GET':
          forward(controller: "dashboardFolder", action: 'folder_profile', id: id)
          return
        case 'PUT':
          forward(controller: "dashboardFolder", action: 'updateFolderProfile', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardFolder", action: 'deleteFolder', id: id)
          return
        default:
          break
        }
      } else if(idObj instanceof IdOrg) {
        switch(request.method) {
        case 'GET':
          forward(controller: "dashboardOrg", action: 'profile', id: id)
          return
        case 'PUT':
          forward(controller: "dashboardOrg", action: 'updateOrgProfile', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardOrg", action: 'deleteOrg', id: id)
          return
        default:
          break
        }
      } else if(idObj instanceof IdUser) {
        // we don't allow users to view other users' profile
      }
    }
    render view: '404'
  }

  @Secured(['ROLE_USER'])
  def forwardMember() {
    def id = params.id

    if(id) {
      def idObj = orgUserTeamService.findIdObjBySlugId(id)
      if(!idObj) {

      } else if(idObj instanceof IdFolder) {
        switch(request.method) {
        case 'GET':
          forward(controller: "dashboardFolder", action: 'folder_members', id: id)
          return
        case 'POST':
          forward(controller: "dashboardFolder", action: 'addFolderMember', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardFolder", action: 'folderMembersRemove', id: id)
          return
        default:
          break
        }
      } else if(idObj instanceof IdOrg) {
        switch(request.method) {
        case 'GET':
          forward(controller: "dashboardOrg", action: 'members', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardOrg", action: 'orgMembersRemove', id: id)
          return
        default:
          break
        }
      }
    }

    render view: '404'
  }

  @Secured(['ROLE_USER'])
  def forwardInvited() {
    def id = params.id

    if(id) {
      def idObj = orgUserTeamService.findIdObjBySlugId(id)
      if(!idObj) {

      } else if(idObj instanceof IdFolder) {
        switch(request.method) {
        case 'POST':
          forward(controller: "dashboardFolder", action: 'inviteFolder', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardFolder", action: 'folderInvitedRemove', id: id)
          return
        default:
          break
        }
      } else if(idObj instanceof IdOrg) {
        switch(request.method) {
        case 'POST':
          forward(controller: "dashboardOrg", action: 'inviteOrg', id: id)
          return
        case 'DELETE':
          forward(controller: "dashboardOrg", action: 'orgInvitedRemove', id: id)
          return
        default:
          break
        }
      }
    }

    render view: '404'
  }

  @Secured(['permitAll'])
  def error403() {
    render view: '403'
  }

  @Secured(['permitAll'])
  def error404() {
    render view: '404'
  }

  @Secured(['permitAll'])
  def error500() {
    render view: '500'
  }
}
