Chapters:
    <g:formRemote name="addChapter" url="[controller:'chapter', action:'add']" update="chapters">
      Num: <input type="text" name="num"><br>
      Name: <input type="text" name="name">
      <input type="hidden" name="manga.id" value="${mangaId}">
      <input type="submit" value="add chapter">
    </g:formRemote>
  <g:select id="chapterSelect" from="${chapters}" optionKey="id" value="${current?.id}/>
