package ru.readmanga

class Manga {

//    static searchable = [only: ['name', 'engName', 'jpName']]
    List<Genre> genres
    List<Book> books
    List<Translator> translators
    String name
    String engName
    String jpName
    String linkName = ""
    String description
    String picture
    Set<Chapter> chapters
    boolean completed = false
    boolean translationCompleted = false
    boolean single = false
    boolean mature = false
    int volumeCount = 1
    int rating = 0    
    int topicId = 0
    static hasMany = [chapters: Chapter, genres: Genre, 
                      translators: Translator, books: Book]    
    
    def beforeInsert = {
      linkName = engName.encodeAsLink()
    }
   
    def beforeUpdate = {
      linkName = engName.encodeAsLink()
    }

    static constraints = {
      name(nullable: true)
      picture(nullable: true)
      jpName(nullable: true)
      engName(unique: true)
      description(nullable: true, maxSize:10000)
    }
    static mapping = {
      chapters sort:'num'
    }
   
   public def getName(String lang) {
     switch(lang) {
       case 'ru': return name
       case 'us': return engName 
       case 'jp': return jpName ?: engName
       default: return engName
     }
   }
   
   public def getGenresList() {
     String list = ""
     boolean first = true;
     genres.each {
       if(!first) list += ', '
       list += it.title
       first = false
     }
     list
   }
   
   public String toString() {
     "Manga{id=${id}, engName='${engName}', genres=${genres}}"
   }
}
