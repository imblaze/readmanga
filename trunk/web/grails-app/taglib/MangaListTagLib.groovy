import java.text.*
import ru.readmanga.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class MangaListTagLib {
  static namespace = "m"
  static formatter = new SimpleDateFormat('dd.MM.yyyy') // hh:mm'

  def mangaService 
  def mangaList = { attrs, body ->
    def list = mangaService.list()
    list.each { manga ->
      out << body(m: manga)
    }
  }

  def df = { attrs ->
    if(attrs.value)
      out << formatter.format(attrs.value)
  }

  def stripHtml = {attrs ->
    if(attrs.value)
      out << attrs.value.replaceAll("<.*?>","");
  }

  def block = { attrs ->
    out << SiteBlock.findByName(attrs.name)?.body
  }
  
  def page = { attrs, body -> 
     def block = SiteBlock.findByName(attrs.name)
     if(block && block.body.trim().size()>0) 
       out << link(controller: 'block', action: 'index', params: [name: attrs.name], body())
     else out << body()
  }
  
  def mangaLocationName = {attrs ->
    def m = attrs.manga
    if (m) {
      for (c in m.chapters) {
        out << c?.sub?.location?.name()
        return
        }
    }
    out << Location.LOCAL.name()
  }

    def linkToManga = {attrs, body ->
        def text = attrs.text ?: body()

        if (attrs.target) {
            out << link(controller: "view", action: "index", title: attrs.manga?.genresList ?: "", target: attrs.target, params: [name: attrs.manga?.linkName], text)
        } else {
            out << link(controller: "view", action: "index", title: attrs.manga?.genresList ?: "", params: [name: attrs.manga?.linkName], text)
        }
    }

    def linkToChapter = {attrs, body ->
        def c =attrs.c
        def manga = attrs.manga ?: c.manga
        def params = [name: manga?.linkName, num: c.num, vol: c.vol, mature: attrs.mature];
        def text = body()
        if (!attrs.hideNew && c.sub?.lastUpdated > new Date()-7 ) text+=" <sup><span class='chapterNew'>Новое</span></sup>"
        if (attrs.page) params.put('page',attrs.page)
        if (attrs.target) {
            out << link(controller: "view", action: "chapter", target: attrs.target, params: params, text)
        } else {
            out << link(controller: "view", action: "chapter", params: params , text)
        }
    }

  def linkToUser={attrs ->
    out<< "<a class='userName' href='/forum/user/profile/${attrs.user?.forumId}.page'>${attrs.user?.username}</a>"
  }

  def ifAdsense={attrs,body ->
    if (CH.config.manga.advertisement.google){
      out<<body()
    }
  }

  def ifNotAdsense={attrs,body ->
    if (!CH.config.manga.advertisement.google){
      out<<body()
    }
  }

    def button = {attrs,body ->
        def writer = out
        writer << '<button onclick="location.href=\''
        // create the link
        if (request['flowExecutionKey']) {
            if (!attrs.params) attrs.params = [:]
            attrs.params."_flowExecutionKey" = request['flowExecutionKey']
        }

        writer << createLink(attrs).encodeAsHTML()
        writer << '\'"'
        // process remaining attributes
        attrs.each {k, v ->
            writer << " $k=\"$v\""
        }
        writer << '>'
        writer <<body()
        writer << "</button>"

    }

    def shortString = {attributes ->
        String text = attributes.text
        int length = attributes.length ? Integer.parseInt(attributes.length) : 100

        if (text) {
            if (text.length() < length)
            out << text.encodeAsHTML()
            else {
                text = text[0..length - 1]
                if (text.lastIndexOf('. ') != -1)
                out << text[0..text.lastIndexOf('. ')]
                else if (text.lastIndexOf(' ') != -1)
                out << text[0..text.lastIndexOf(' ')] << '&hellip;'
                else
                    out << text << '&hellip;'
            }
        }
    }
}
