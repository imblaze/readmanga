import ru.readmanga.*

class SubmissionService extends Xmlrpc {
    def chapterService
    boolean transactional = true

  String postChapter(params) {

    def (mangaName, vNum, cNum, text) = params
    def m = Manga.findByEngName(mangaName)
    if (!m) return 'manga not found'
    def c = chapterService.find(m, vNum as int,cNum as int)
    def answer="Done. "

    if (c){
      c.sub?.delete(flush: true)
      answer="Chapter Updated!"
    } else {
      c = new Chapter(vol: vNum, num: cNum, manga: m)
      if (!c.save()) return c.errors
    }
    def sub = new Submission()
    post(sub, text, false)
    if (sub.hasErrors()) return sub.errors
    sub.chapter = c
    if (!sub.save()) return sub.errors
    return answer
  }
    
    def listUrlsLike(params) {
       def (prefix, locationName) = params
       def location = Location.valueOf(locationName)
       def list = []
       Submission.executeQuery('from Page as p where p.submission.location = :loc and p.url like :prefix', [loc: location, prefix: "${prefix}%"]).each {
         list.add([url: it.url, type: it.type.name()])
       }
       return list
     }

    def switchLocation(params) {
       def (prefix, oldLocationName, locationName) = params
       def oldLocation = Location.valueOf(oldLocationName)
       def location = Location.valueOf(locationName)
       int count = 0;
       Submission.executeQuery('select distinct submission from Page as p where p.submission.chapter is not ' +
                                'null and p.submission.location = :loc and p.url like :prefix', [prefix: "${prefix}%", loc: oldLocation]).each { s ->
           s.location = location
           s.save()
           count++
         }
       return count
    }

    def post(Submission sub, String text, boolean breakOnError = true, String dirName = '') {
        def lines = text.split('\n');
        StringBuffer errors = new StringBuffer()
        for(String line : lines) {
          def vals = line.split('\t| +')
          if(vals.size() != 6)
            {
              if(breakOnError) {
                sub.errors.rejectValue('pages', 'submission.pages.line', "invalid number of columns in line '$line'")
              }
              continue;
            }

            Page page = new Page(url: dirName + vals[0], type: ImageType.valueOf(vals[1]), size: vals[2], w: vals[3], h: vals[4], md5: vals[5])
            sub.addToPages(page)
        }
    }

    def renameChapters(c, String text){
      def lines = text.split('\n');
      for(String line : lines) {
          def parts = line.split('%')
          if(parts.size() >1)
            {
              def fullNumber= parts[0].trim()
              if (fullNumber.indexOf('.')>-1){
                 def numbers=fullNumber.split('\\.')
                  renameChapter(parts[1],c,numbers[1],numbers[0])
              } else{
                  renameChapter(parts[1],c,fullNumber,null)
              }
            }
        }
    }

    def renameChapter(String text, c, num, vol) {
        text = text?.trim()
        if (text == null || text.length() == 0) {
            // add message
            return
        }
        def chapters
        def number=Integer.valueOf(num?.trim())
        if (vol) {
            def volum=Integer.valueOf(vol?.trim())
            chapters = c.findAll {item -> item.num == number && item.vol == volum }
        } else {
            chapters = c.findAll {item -> item.num == number}
        }
        if (chapters.size() == 1) {
            def chapter = chapters.asList().get(0)
            chapter.name = text;
            chapter.save()
        }
        else {
//                add message
        }
    }


    def deleteChapter(Manga m, vol, cNum) {
    def c = chapterService.find(m, vol as int, cNum as int)
    c?.sub?.delete()
    c?.delete()
  }

}
