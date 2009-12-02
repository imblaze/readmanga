package ru.readmanga

import org.apache.shiro.grails.annotations.RoleRequired
import org.apache.shiro.SecurityUtils

class TwitterController {
    static layout = 'public'
    def index = { }

    @RoleRequired("USER")
    def add = {
      [m:Manga.get(params.mangaId)]
    }

    @RoleRequired("USER")
    def saveTwitt = {
      def sub  = Submission.get(params.subId)
      def message = params.message?.trim()?.encodeAsHTML()
      message = message.length() >= 80 ? message.substring(0, 80) : message
      if (message.length() > 0) {
        def tw = new Twitt(message: message, sub: sub, page: params.page, user: SecurityUtils.subject?.principal)
        tw.save()
      }
        def c  = sub.chapter
      redirect(controller: "view", action: "chapter", params: [vol: c.vol, num: c.num, page: params.page, name: c.manga.linkName, mature: params.mature])
    }
}
