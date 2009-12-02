package ru.readmanga
import ru.readmanga.*

class SubmissionController {
    def defaultAction = 'list'
    def mangaService
    def submissionService
 
    def rpc = {
      submissionService.service(request, response)
    }
    
    def listFeedback = {
      [list: Feedback.list().reverse() ]
    } 
  
    def listManga = {
      [list: Manga.list(sort:'id', order:'desc')]
    }
    
    def editManga = {
      def m = Manga.get(params.id)
      println m.genres
      println Genre.list()
      //todo: move all T...list(...) to service
      [m: m, mangaTrans: m.translators, trans: Translator.list(sort: 'name'),mangaGenres: m.genres, genres:Genre.list(sort: 'name') ]
    }

    def saveManga = {
      def m = Manga.get(params.id)
      m.properties = params
      submissionService.renameChapters(m.chapters,params.chaptersNames)
      m.save()
      redirect(action: "listManga")
    }

    def list = {
        def subs = Submission.findAllByChapterIsNotNull([sort: 'dateCreated', order: 'desc', max: 20])
        [list: subs]
    }

    def get = {
        Submission sub = Submission.get(params.id)
        [sub: sub]
    }
    
  def listChapters={
     def m = Manga.get(params.id)
     [m:m, chapters:m.chapters]
   }

  def deleteChapter = {
    def m = Manga.get(params.manga)
    submissionService.deleteChapter(m, params.vol, params.num)
    redirect(action: 'listChapters', params: [id: params.manga])
  }

  def renameChapter={
      def m = Manga.get(params.mangaId)
      submissionService.renameChapter(params.chapterName, m.chapters, params.num, params.vol)
      render("Saved");
  }

  def addManga = {
     def m = new Manga(params)
     m.engName = m.name
     m.save()
     redirect(action:'editManga',params:[id:m.id])
  }

}
