import ru.readmanga.*

class ChapterService {

    boolean transactional = false

    def findByMangaId(def mangaId, boolean reverse = false) {
       String order = reverse ? 'desc' : 'asc' 
       return  Chapter.findAll("from Chapter as c where c.sub.hidden = false and c.manga.id = ? order by vol $order, num $order", [mangaId.toLong()])
    }
   
    def find(Manga m, int vol, int num) {
       return  Chapter.findAll("from Chapter as c where c.manga = ? and c.vol = ? and c.num = ?", [m, vol, num])[0]
    }
  
    
    def listLatest(def pageParams) {
       return Submission.findAll("from Submission as s where s.hidden = false order by s.dateCreated desc", [], pageParams)
    }
}
