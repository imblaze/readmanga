package ru.readmanga.admin
import ru.readmanga.*
import org.apache.shiro.grails.annotations.RoleRequired
import org.apache.shiro.SecurityUtils

class ModerationController {
    def submissionService
    def mangaService
    @RoleRequired("MODERATOR")
    def index = {
        def subject = SecurityUtils.subject
        def perm = subject?.hasRole(ShiroRole.MODERATOR)
        println "Has moderator role ${perm}"
        def subs = Submission.findAllByHidden(true, [sort: 'dateCreated', order: 'desc'])

        def mangaEdits = MangaEditInfo.list()
        [list: subs, edits:mangaEdits]
    }

    @RoleRequired("MODERATOR")
    def approveUpload ={
        def sub = Submission.get(params.id)
        sub.hidden = false
        sub.save()
        redirect(action: "index")
    }

    @RoleRequired("MODERATOR")
    def deleteChapter = {
        def m = Manga.get(params.manga)
        submissionService.deleteChapter(m, params.vol, params.num)
        redirect(action: "index")
    }

    @RoleRequired("MODERATOR")
    def approveMangaEdit ={
        def p = MangaEditInfo.get(params.id)
        def m = p.manga
        m.properties=p.properties
        mangaService.saveMangaRemoveHtml(m)
        p.delete()
        redirect(action: "index")
    }

    @RoleRequired("MODERATOR")
    def deleteMangaEdit = {
        def p = MangaEditInfo.get(params.id)
        p.delete()
        redirect(action: "index")
    }
}
