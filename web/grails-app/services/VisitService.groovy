import ru.readmanga.*

class VisitService {

    boolean transactional = true

    def add(def manga, def chapter, def request) {
        def info = request.getHeader("User-Agent")
        if (info?.length() > 200)
            info = info.substring(0, 200)
      BrowserInfo browserInfo = BrowserInfo.findByInfo(info)
      if (!browserInfo) {
        browserInfo = new BrowserInfo(info: info)
        if (!browserInfo.save())
          println browserInfo.errors
      }

      def visit = new Visit(manga: manga, chapter: chapter, ip: request.remoteAddr, sessionId: request.requestedSessionId, browserInfo:browserInfo)
      if(!visit.save())
        println visit.errors
    }
}
