Manga translators: <br>

<g:formRemote name="delTransFromManga" url="[action: 'del', controller: 'translatorWidget']" update="mangaTransList">
  <g:select name="mangaTrans" from="${mangaTrans}" size="5" optionValue="name" optionKey="id"/>
  <input type="hidden" name="mangaId" value="${m.id}">
  <button type="submit">Remove</button>
</g:formRemote>