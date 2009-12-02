<html>
  <head>
    <meta name="layout" content="main">
  <g:javascript library="prototype"/>
  </head>
  <body>
  <h1>Chapter Editor</h1>
  <div id="resultFiels">
  </div>
  <h5>Manga: ${m.engName}</h5>
  <table class="cTable"><tr><th class="headL"></th><th width=450>name</th><th width=50>vol</th><th width=50>num</th><th width=50>delete</th><th width=80>location</th><th width=50>pics</th><th class="headR"></th></tr>
    <g:each var="c" in="${chapters}">
            <tr>
              <td/>
              <td>
                <g:formRemote name="chapterName_${c.vol}_${c.num}" url="[action: 'renameChapter']" update="resultFiels">
                  <g:textField name="chapterName" width="300" value="${c.name}"/>
                  <input type="hidden" name="mangaId" value="${m.id}">
                  <input type="hidden" name="vol" value="${c.vol}">
                  <input type="hidden" name="num" value="${c.num}">
                  <button type="submit">save</button>
                </g:formRemote>


              </td>
              <td>${c.vol}</td>
              <td>${c.num}</td>
              <td>
                <g:link action="deleteChapter" params="[manga: m.id, num: c.num, vol: c.vol]">delete</g:link>
              </td>
              <td><g:message code="location.name.${c.sub?.location?.id}"/></td>
              <td>
                <g:link action="get" id="${c.sub?.id}">show</g:link>
              </td>
              <td/>
            </tr>
          </g:each>
    </table>
  </body>
</html>

