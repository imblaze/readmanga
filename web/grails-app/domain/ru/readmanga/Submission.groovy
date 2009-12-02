package ru.readmanga

enum Location {
  LOCAL(1, 'http://i.readmanga.ru/'), AMAZON(2, 'http://s.readmanga.ru/'), DE(3, 'http://d.readmanga.ru/'), AGAVA(4,'http://m.readmanga.ru/'), 
  DEV(5, 'http://localhost/static/'), DE_AUTO(6, 'http://d.readmanga.ru/auto/'), AGAVA_AUTO(7, 'http://m.readmanga.ru/auto/');
  final int id
  final String prefix
  Location(int id, String prefix) { 
    this.id = id 
    this.prefix = prefix
  }
}

class Submission {

    List<Page> pages
    static hasMany = [pages: Page, twitts: Twitt]
    Chapter chapter
    Date dateCreated
    Date lastUpdated
    boolean hidden = false
    ShiroUser user
    Location location = Location.DE

    static belongsTo = Chapter
  
    static constraints = {
      user(nullable: true)
    }
    
    static mapping = {
      pages(index: 'submission_pages_idx')
    }
    void setChapter(Chapter c) {
       this.chapter = c
       c?.setSub(this)
    }
}
