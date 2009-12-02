<html>
<meta name="layout" content="main">
  <body>
  <content tag="leftContent">
    <h1>Manga list</h1>
    <table class="cTable">
      <tr>
        <th class="headL"></th>
        <th  width="30">id</th><th width="400">name</th><th width="70">location</th><th  width="50">edit</th><th  width="50">chapters</th>
        <th/>
        <th class="headR"></th>
      </tr>
    <g:each var="m" in="${list}">
     <tr>
       <td/>
       <td>${m.id}</td>
       <td><m:linkToManga manga="${m}" target="_blank">${m.engName}</m:linkToManga></td>
       <td><m:mangaLocationName manga="${m}"/></td>
       <td><g:link action="editManga" id="${m.id}">edit</g:link></td>
       <td><g:link action="listChapters" id="${m.id}">chapters</g:link></td>
       <td><g:link controller="upload" action="chapters" params="[manga:m.id]">upload</g:link></td>

       <td/>
     </tr>
    </g:each>
    </table>
    </content>

    <content tag="rightContent">
      <g:form name="addManga" url="[action:'addManga']">
      <input type="text" name="name">
        <br/>
        <br/>
      <button type="submit" >Create new manga</button>
    </g:form>
      <br/>
      <br/>
      <h1><g:link controller="genres">Genres</g:link></h1>
      <h1><g:link controller="translators">Translators</g:link></h1>
    %{--<g:link action="asoc">Create new manga</g:link><br>--}%
  </content>
  </body>
</html>
