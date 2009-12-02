package ru.readmanga.admin
import ru.readmanga.*

class GenreController {
  def addToManga = {
    def m = Manga.get(params.mangaId)
    def g = Genre.get(params.genres)
    m.addToGenres(g)
    m.save()
    render(template: '/admin/genres/showGenres', model: [mangaGenres: m.genres, m: m])
  }

  def deleteFromManga = {
    def m = Manga.get(params.mangaId)
    def g = Genre.get(params.mangaGenres)
    m.genres.remove(g)
    m.save()
    render(template: '/admin/genres/showGenres', model: [mangaGenres: m.genres, m: m])
  }
}
