<html>
<meta name="layout" content="main">
  <body>
    <h1>Submissions list</h1>
    <table border=1><tr><th>id</th><th>created</th><th>updated</th><th>chapter</th></tr>
    <g:each var="s" in="${list}">
     <tr>
       <td><g:link action="get" id="${s.id}">${s.id}</g:link></td>
       <td>${s.dateCreated}</td>
       <td>${s.lastUpdated}</td>
       <td>
         ${s.chapter.manga.name} - ${s.chapter.num}
       </td>
     </tr>
    </g:each>
    </table>

  </body>
</html>
