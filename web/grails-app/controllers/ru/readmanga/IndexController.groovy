package ru.readmanga
import common.api.SharedMap
import org.apache.shiro.SecurityUtils

class IndexController {
    def cookieService

    private static final MAX = 30
    //todo: move to cache service
    private static stat;
    private static Date statUpdate
    private static lastTwitts
    private static long twittsUpdate

    static layout = 'public'
    def chapterService  
    def mangaService
    
    def index = {
      def total = Submission.countByChapterIsNotNull()
      def max = params.max?.toInteger() ?: MAX
      if(max>30) max = MAX
      def offset = params.offset?.toInteger() ?: 0
      if(!statUpdate || statUpdate + 1 < new Date()) {
        stat=[gb: mangaService.getMangaAmount(), manga: Manga.count(),pages:Page.count(), chapters: Chapter.count()]
        statUpdate = new Date()
      }
        
      if(!twittsUpdate || twittsUpdate + 30000 < new Date().time) {
        lastTwitts = Twitt.list(sort: 'dateCreated', order: 'desc', max: 10)
        twittsUpdate = new Date().time
      }

      return( [list: chapterService.listLatest([max: max, offset: offset]), total: total, stat:stat, genres:Genre.list(sort: 'title', order: 'asc'), lastTwitts:lastTwitts] )
     }

  def sitemap = {
    def manga = mangaService.listFull()
    def list=["http://readmanga.ru/":"0.9","http://readmanga.ru/list":"0.9",
            "http://readmanga.ru/about":"0.3", "http://readmanga.ru/forum/forums/list.page":"0.9",
            "http://readmanga.ru/forum/recentTopics/list.page":"0.9", "http://readmanga.ru/forum/forums/show/2.page":"0,9"]
    render(contentType: 'text/xml',encoding:"UTF-8") {
      mkp.yieldUnescaped('<?xml version="1.0" encoding="UTF-8"?>\n')
      urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") {
        list.each{k,v->
          url {
            loc(k)
            changefreq("daily")
            priority(v)
          }
        }
        manga.each {m ->
          url {
            loc("http://readmanga.ru/${m.linkName}")
            changefreq("weekly")
            priority("0.5")
          }
        }
      }
    }
  }

    def authenticateInfo ={
        def value = cookieService.getCookie(request, 'forumSessionId')?.value
        def jforumUserId = cookieService.getCookie(request, 'jforumUserId')?.value
        def jforumUserHash = cookieService.getCookie(request, 'jforumUserHash')?.value
        def jforumAutoLogin = cookieService.getCookie(request, 'jforumAutoLogin')?.value
        def session = request.getSession(true)
        def user = SharedMap.get("forumCache")?.get("sessions/logged", value)?.user

        def facade = SharedMap.get("forumFacade")
        def cookieUser = SharedMap.get("forumFacade")?.getUserByCookie(request.cookies)


        def authenticated = SecurityUtils.subject.authenticated
        def name = SecurityUtils.subject?.principal?.username
        [cookieSesId:value, authenticated:authenticated, seached: session.alreadySeached, user:user, facade: facade,cookieUser:cookieUser, name:name, jforumAutoLogin:jforumAutoLogin, jforumUserHash:jforumUserHash, jforumUserId:jforumUserId]
    }
}
