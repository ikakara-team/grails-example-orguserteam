package ikakara.exampleout.web.app

import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class SiteController {
  def index() { }

  def error403() {
    render view: '403'
  }

  def error404() {
    render view: '404'
  }

  def error500() {
    render view: '500'
  }
}
