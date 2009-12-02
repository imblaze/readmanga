package ru.readmanga

import org.apache.shiro.grails.annotations.RoleRequired
import org.apache.shiro.SecurityUtils

class UploadController {
    static layout = 'public'

    def uploadService

    def index = {
      render(view: 'index')
    }
    
    @RoleRequired("USER")
    def chapters = {
        def messages = []
        flash.messages = messages
        def mangaId = params.manga
        def m = Manga.get(params.manga)
//        def t = params.translater ?: 0
//        def transl = Translator.get(t) // todo add default translater

        def subject = SecurityUtils.subject
        def perm = subject?.hasRole(ShiroRole.ADMIN) || subject?.hasRole(ShiroRole.MODERATOR) /*|| subject?.principal?.trans?.id == transl*/

        //todo if has permissions to this manga
        if (!perm) messages << "upload.permission.not"

        (1..10).each {
            def v = params["vol${it}"]
            def c = params["chapter${it}"]
            def uploadFile = params["file${it}"]

            if (uploadFile && !uploadFile.empty) {
                uploadService.saveFile(m, v, c, uploadFile, messages, null, subject)
            }
        }

        def trans = Translator.list(sort: 'name', order: 'asc')
        [mangas: Manga.list(sort: 'engName', order: 'asc'), curId: mangaId, trans: trans]
    }
}
