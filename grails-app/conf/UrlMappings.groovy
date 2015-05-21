import java.nio.file.AccessDeniedException

class UrlMappings {

  static mappings = {
    // site
    "/"(controller: "site", action: "index")
    // app urls
    "/$id"(controller: "site", action:"forward")
    "/$id/profile"(controller: "site", parseRequest: true) {
      action = [GET: "forward", PUT: "forward", DELETE: "forward"]
    }
    "/$id/members"(controller: "site", parseRequest: true) {
      action = [GET: "forwardMember", POST: "forwardMember", DELETE: "forwardMember"]
    }
    "/$id/invited"(controller: "site", parseRequest: true) {
      action = [POST: "forwardInvited", DELETE: "forwardInvited"]
    }
    "/$id/folders"(controller: "dashboardOrg", parseRequest: true) {
      action = [GET: "orgFolders"]
    }
    "/$id/videos"(controller: "dashboardFolder", parseRequest: true) {
      action = [GET: "folder_videos", POST: "upload_video"]
    }
    "/welcome"(controller: "dashboardUser", action: "memberships")
    "/my-memberships"(controller: "dashboardUser", action: "memberships")
    "/my-profile/"(controller: "dashboardUser", parseRequest: true) {
      action = [GET: "profile", PUT: "updateProfile"]
    }
    "/my-settings/"(controller: "dashboardUser", parseRequest: true) {
      action = [GET: "settings", PUT: "updateSettings", POST: "changePassword"]
    }

    // api-ish urls - a couple ajax gets in the app
    "/my-invitations/$id?(.$format)?"(controller: "dashboardUser", parseRequest: true) {
      action = [GET: "invitations", POST: "joinInvitation", DELETE: "deleteInvitationTBD"]
    }
    "/my-orgs/$id?(.$format)?"(parseRequest: true) {
      controller = [GET: "dashboardUser", POST: "dashboardUser"]
      action = [GET: "orgs", POST: "saveOrg"]
    }
    "/my-folders/$id?(.$format)?"(parseRequest: true) {
      controller = [GET: "dashboardUser", POST: "dashboardOrg"]
      action = [GET: "folders", POST: "saveFolder"]
    }
    "/my-groups(.$format)?"(controller: "dashboardUser", action: "groups")

    // errors
    "403"(controller: "site", action: "error403")
    "404"(controller: "site", action: "error404")
    "500"(controller: "site", action: "error403", exception: AccessDeniedException)
    "500"(controller: "site", action: "error500")

    // admin
    "/admin"(controller: "admin", action: "index")
    // kept for posterity
    "/$controller/$action?/$id?(.$format)?"{
      constraints {
        // apply constraints here
      }
    }
  }
}
