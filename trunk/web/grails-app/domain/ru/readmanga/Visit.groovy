package ru.readmanga

class Visit {
    Manga manga
    Chapter chapter
    Date dateCreated
    String ip 
    String sessionId
    BrowserInfo browserInfo
    static belongsTo = [browserInfo: BrowserInfo]
    static constraints = {
      chapter(nullable: true)
      sessionId(nullable: true)
    }
    static mapping = {
      version false
    }
}
