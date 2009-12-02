<html>
  <head>
    <meta name="layout" content="main">
  <g:javascript library="prototype"/>
  </head>
  <body>
  <h1>Manga moderation</h1>
  <h5>Uploads:</h5>
  <table class="cTable">
    <tr><th class="headL"></th><th width=450>Manga</th><th width=80>approve</th><th width=50>vol</th><th width=50>num</th><th width=50>delete</th><th width=50>pics</th><th width=50>user</th><th class="headR"></th></tr>
    <g:each var="s" in="${list}">
            <tr>
              <td/>
                <td><m:linkToManga manga="${s.chapter.manga}" target="_blank">${s.chapter.manga?.engName}</m:linkToManga></td>
              <td>
                <g:link action="approveUpload" params="[id: s.id]">approve</g:link>
              </td>
              <td>${s.chapter.vol}</td>
              <td>${s.chapter.num}</td>
              <td>
                <g:link action="deleteChapter" params="[manga: s.chapter.manga?.id, num: s.chapter.num, vol: s.chapter.vol]">delete</g:link>
              </td>
              <td>
                <g:link controller="submission" action="get" id="${s?.id}" target="_blank">show</g:link>
              </td>
              <td>
                <m:linkToUser user="${s?.user}"/>
              </td>
              <td/>
            </tr>
          </g:each>
    </table>

  <br/>
  <br/>
  <h5>Edits:</h5>
  <table class="cTable">
    <tr><th class="headL"></th><th width=450>Manga</th><th width=80>see</th><th width=50>user</th><th class="headR"></th></tr>
    <g:each var="p" in="${edits}">
      <tr>
        <td/>
        <td><m:linkToManga manga="${p.manga}" target="_blank">${p.manga?.engName}</m:linkToManga></td>
        <td>
          <g:link controller="editor"  action="reviewEditInfo" params="[id: p.id]">see</g:link>
        </td>
        <td>
          <m:linkToUser user="${p.user}"/>
        </td>
        <td/>
      </tr>
    </g:each>
    </table>
  </body>
</html>

