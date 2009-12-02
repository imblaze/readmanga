package ru.readmanga

class Chapter {
    int num
    int vol = 1
    boolean extra = false

    String name
    Manga manga
    Submission sub
    static belongsTo = [manga: Manga]
    
    static constraints = {
       name(nullable: true)
       sub(nullable: true)
       num(unique:['manga', 'vol'])
    }
    
    static mapping = {
	sort 'num'
    }

    String toString() {
      "$num${name? ' - ' + name : ''}"
    }
    
    //todo: move this methods to tags and generate link
    def getTitle() {
      if (manga?.single) {
        return "Сингл"
      }
      "${vol} - ${num}${name ? ' ' + name :''}" //todo change to g.message(code: "dfd")  
    }
   
}
