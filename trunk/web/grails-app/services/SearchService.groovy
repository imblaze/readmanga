import ru.readmanga.*
class SearchService {

  boolean transactional = false

  def search(q) {
    List list
    List words = q.split(' ')
    
    if (words.size()>0) 
      list = findWord(words[0])
    words.remove(0)
    if(words.size() > 0)
      words.each {
        list = list.intersect(findWord(it))
      }
    list = list.sort {it.engName}
    return [mangaResults: list, q: q.encodeAsHTML()]

  }

  def findWord(word) {
      def c = Manga.createCriteria()
      c.list {
        or {
          ilike("engName", "%$word%")
          ilike("name", "%$word%")
          ilike("jpName", "%$word%")
        }
      }
  }
  
}
