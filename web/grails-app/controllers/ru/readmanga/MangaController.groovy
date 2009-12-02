package ru.readmanga

import org.apache.shiro.grails.annotations.RoleRequired

class MangaController {
  static layout = 'public'
  def mangaService

  private Map group(list, lang) {
    list.groupBy { it.getName(lang).substring(0, 1).toUpperCase()}.sort{it.key}
  }

  def index={
    def list
    def grouped=null
    if (params.sortType=="RATING"){
        list = Manga.list(sort: 'rating', order: 'desc')
    }else{
        list = Manga.list(sort: 'engName', order: 'asc')
        grouped= group(list, params.lang)
    }
    render(view: "list", model: [genres:Genre.list(sort: 'title', order: 'asc'),list:list, grouped: grouped])
  }

  def genre={
    def list
    def grouped=null
    if (params.sortType=="RATING"){
        list = Manga.executeQuery('select m from Manga as m inner join m.genres as g where g.name = ? order by m.rating desc', [params.id])
    }else{
        list = Manga.executeQuery('select m from Manga as m inner join m.genres as g where g.name = ? order by m.name', [params.id])
        grouped= group(list, params.lang)
    }

    render(view: 'list',model:[grouped:grouped,list:list, genres:Genre.list(sort: 'title', order: 'asc'), genre: Genre.findByName(params.id)])
  }

}
