package ru.readmanga

class RssController {
    def mangaService
    def chapterService

  def index = {
    def results = chapterService.listLatest([max: 100, offset: 0])
    render(contentType: 'application/rss+xml') {
      rss(version: '2.0') {
        channel {
          title('Новости ReadManga.ru')
          description(SiteBlock.findByName('news')?.body)
          link('http://readmanga.ru')
          results.each {s ->
            item {
              title("${s.chapter.manga.name} ${s.chapter.title}")
              link("http://readmanga.ru/${s.chapter.manga.linkName}/vol${s.chapter.vol}/${s.chapter.num}")
              pubDate(s?.dateCreated) // might want to put something useful in here
            }
          }
        }
      }
    }

  }

  def manga = {  //get rss by manga name
    def manga = Manga.findByLinkName(params.name)
    if (manga == null) {
      render(contentType: 'application/rss+xml') {
        rss(version: '2.0') {
          channel {
            title('Манга не найдена')
            description('Возможно был введен неверный адрес')
            link('http://readmanga.ru')
          }
        }
      }
    }

    def chapterList = chapterService.findByMangaId(manga.id, true)

    render(contentType: 'application/rss+xml') {
      rss(version: '2.0') {
        channel {
          title("Манга ${manga.name}")
          description("Последние главы для манги ${manga.name}")
          link("http://readmanga.ru/${manga.linkName}")
          lastBuildDate(new Date())
          chapterList.each {c ->
            item {
              title("${manga.name} ${c.title}")
              description("${manga.name} ${c.title}")
              link("http://readmanga.ru/${manga.linkName}/vol${c.vol}/${c.num}")
              pubDate(c.sub?.dateCreated) // might want to put something useful in here
            }
          }
        }
      }
    }

  }

}
