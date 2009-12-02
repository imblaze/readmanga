Manga genres: <br>
<g:formRemote name="delGenreFromManga" url="[action: 'deleteFromManga', controller: 'genre']" update="mangaGenresList">
  <g:select name="mangaGenres" from="${mangaGenres}" size="5" optionValue="title" optionKey="id"/>
  <input type="hidden" name="mangaId" value="${m.id}">
  <button type="submit">Remove</button>
</g:formRemote>
