package ru.readmanga

import org.apache.shiro.grails.annotations.RoleRequired
import org.apache.shiro.SecurityUtils
import org.apache.shiro.subject.Subject

class EditorController {
    static layout = 'public'
    def index = { }
    def mangaService
    @RoleRequired("USER")
    def editManga ={
      //todo if admin....
      def m = Manga.get(params.id)
      [mangaId:m.id, name:m.name, m: m ]
    }

    @RoleRequired("USER")
    def saveManga = {
        Subject subject = SecurityUtils.subject
        def m = Manga.get(params.mangaId)
        if (subject?.hasRole(ShiroRole.ADMIN) || subject?.hasRole(ShiroRole.MODERATOR)) {
            m.properties = params
            mangaService.saveMangaRemoveHtml(m)
        } else {
            def prop = new MangaEditInfo()
            prop.manga=m
            prop.properties = params
            prop.engName = m.engName
            prop.user = (ShiroUser) subject?.principal
            if (!prop.save()) println prop.errors
        }
        redirect(controller: "view", action: "index", params: [name: m.linkName])
    }

    @RoleRequired("MODERATOR")
    def reviewEditInfo={
        def p=MangaEditInfo.get(params.id)
        render(view: 'editManga', model: [name: p.manga.name, mangaId:p.manga?.id, m: p, moderation:true, pId:p.id])
    }
}
