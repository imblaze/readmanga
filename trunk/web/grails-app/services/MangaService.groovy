import ru.readmanga.*

class MangaService {
    
    boolean transactional = false
    def listFull() {
      Manga.list(sort: 'engName', order: 'asc') 
    }
    def list() {
      Manga.list(sort: 'rating', order: 'desc', max: 15)
    }

  def getMangaAmount(){
    return (Page.executeQuery('select sum(size) from Page')[0]/1048576) as int
  }

   def saveMangaRemoveHtml(m){
//       m.name = m.name?.encodeAsHTML()
       m.engName = m.engName?.encodeAsHTML()
       m.jpName = m.jpName?.encodeAsHTML()
//       m.description = m.description?.encodeAsHTML() //todo  delete only scripts
       if (!m.save()) println m.errors
   }
    
}
