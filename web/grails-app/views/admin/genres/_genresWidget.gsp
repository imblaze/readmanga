<h1>Genres <g:link controller="genres">(Edit)</g:link></h1>
select genres:
<g:formRemote name="addGenresToManga" url="[action: 'addToManga', controller: 'genre']" update="mangaGenresList">
     <g:select name="genres" from="${genres}" optionValue="name" optionKey="id"  noSelection="['':'-Choose genre-']"/>
         <input type="hidden" name="mangaId" value="${m.id}">
         <button type="submit">Add to Manga</button>
</g:formRemote>
     <div id="mangaGenresList">
       <g:render template="/admin/genres/showGenres"/>
     </div>