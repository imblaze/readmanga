package ru.readmanga
import grails.converters.JSON
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import common.api.SharedMap

class ViewController {
    static layout = 'public'
    def chapterService
    def visitService

    def index = {
        def manga = Manga.findByLinkName(params.name)
        if (manga == null)
            return render(status: 404, view: "/error/error404")

        def chapterList = chapterService.findByMangaId(manga.id, true)
        visitService.add(manga, null, request)

        def posts = null
        try {
            posts = SharedMap.get("forumFacade")?.getPosts(manga.topicId)
        } catch (Throwable e) {
            println e
        }
        [chapters: chapterList, m: manga, posts: posts]
    }
 
    def chapter = {
      def m = Manga.findByLinkName(params.name)
      if(m == null) 
        return render(status: 404, view: "/error/error404")

      if(m.mature && !params.mature)
        return redirect(action: 'index', params: [name: params.name])

      def c = chapterService.find(m, params.vol.toInteger(), params.num.toInteger())
      if (c == null)
        return render(status: 404, view: "/error/error404")
      def chapters = chapterService.findByMangaId(m.id, true)
      visitService.add(m, c, request)
      def s = c.sub
      //if (s == null) return render('No submission')
      def pics = []
      s?.pages?.each { p ->
        pics.add([url: s.location.prefix + p.url, w: p.w, h: p.h])
      }
      //get next and prev chapter
      def list = chapterService.findByMangaId(m.id)
      int i = list.indexOf(c)
      def next = i < list.size()-1 ? list[i+1] : null
      def prev = i > 0 ? list[i-1] : null
      def page = params.page ?:0
      def twitts = Twitt.findAllBySub(s, [sort: 'dateCreated', order: 'desc'])

      [m: m, chapters: chapters, c: c, pics: pics as JSON, pSize:pics.size(), next: next, prev: prev, twitts:twitts, page:page]
    }
   
    def topic = {
      def m = Manga.findByLinkName(params.name)
      int topicId = m.topicId
      String forumUrl = CH.config.manga.forum.url
      def forumId=CH.config.manga.forum.id
      if(topicId == 0) {
        String title = "Обсуждение манги ${m.name}".encodeAsURL()
        String text = title //"".encodeAsURL()
        def xml = new XmlSlurper().parse(
            new URL("$forumUrl/topicApi/insert.page?id=$forumId&title=$title&text=$text").openStream())
        topicId = xml.topic.@id.toInteger()
        m.topicId = topicId
        m.save()
      }
      redirect(url: "$forumUrl/posts/list/${topicId}.page")
    }

  def reader = {
    try {
      def m = Manga.findByLinkName(params.name)
      if (m == null)
        return render("wrongManga")

      def c = chapterService.find(m, params.vol.toInteger(), params.num.toInteger())
      if (c == null)
        return render("wrongManga")
      def chapters = chapterService.findByMangaId(m.id, true)
      visitService.add(m, c, request)
      def s = c.sub
      //if (s == null) return render('No submission')
      def pics = []
      s?.pages?.each {p ->
        pics.add([url: s.location.prefix + p.url, w: p.w, h: p.h])
      }
      //get next and prev chapter
      def list = chapterService.findByMangaId(m.id)
      int i = list.indexOf(c)
      def next = i < list.size() - 1 ? list[i + 1] : null
      def prev = i > 0 ? list[i - 1] : null

      [m: m, chapters: chapters, c: c, pics: pics as JSON, pSize: pics.size(), next: next, prev: prev, reader: true, page:0]
    } catch (e) {
      println "External reader error ${e}"
      render(view: "externalError")
    }

    }
}
