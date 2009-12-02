<html>
<head>
  <title><g:message code="manga.edit"/></title>
</head>

  <content tag="leftContent">
    <h1><g:message code="manga.edit"/> "${name}" </h1>
    <g:form action="saveManga" params="[mangaId: mangaId]">

      <h5>Название</h5>
      Русское: <g:textField name="name" value="${m.name}"/><br/>
      Английское: ${m.engName}<br/>
      Японское:<g:textField name="jpName" value="${m.jpName}"/><br/>
      <br/>
      <h5>Информация о манге</h5>
      <g:checkBox name="completed" value="${m.completed}"/> Выпуск завершен <br/>
      <g:checkBox name="translationCompleted" value="${m.translationCompleted}"/> Перевод завершен <br/>
      <br/>
      Количество томов: <g:textField name="volumeCount" class="volume" value="${m.volumeCount}"/><br/>
      <g:checkBox name="single" value="${m.single}"/> Сингл<br/>
      <br/>
      <g:checkBox name="mature" value="${m.mature}"/> <b>Для взрослых</b> <br/>
      <br/>
      Описание манги:<br/>
      <fckeditor:editor
                  name="description"
                  width="630"
                  height="400"
                  toolbar="Standard"
                  fileBrowser="default">
            ${m.description}
          </fckeditor:editor>


      <g:if test="${moderation}">
        <g:link controller="moderation" action="approveMangaEdit" params="[id:pId]">Approve</g:link>
        <g:link controller="moderation" action="deleteMangaEdit" params="[id:pId]">Delete</g:link>
      </g:if>
      <g:else>
        <button class="submit" type="submit">Сохранить</button>
      </g:else>

      </g:form>
  </content>
  <content tag="rightContent">
      %{--<g:render template="/admin/trans/translatorsWidget"/>--}%
    <br/>
  <br/>
      %{--<g:render template="/admin/genres/genresWidget"/>--}%


  </content>

</html>
