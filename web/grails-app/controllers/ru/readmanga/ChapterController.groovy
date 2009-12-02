package ru.readmanga

class ChapterController {
  def chapterService

  def list = {
    render(template:"list", model: [chapters: chapterService.findByMangaId(params.id), mangaId: params.id])
  }

  def add = {
     def c = new Chapter(params)
     c.save()
     def mangaId = params.manga.id 
     render(template:'list', model: [chapters: chapterService.findByMangaId(mangaId), mangaId: mangaId, current: c])
  }
}
