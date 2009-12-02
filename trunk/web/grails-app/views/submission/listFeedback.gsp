<html>
<meta name="layout" content="main">
  <body>
    <h1>Feedback list</h1>
    <table class="cTable"><tr><th class="headL"></th><th>id</th><th>date</th><th>name</th><th>type</th><th>text</th><th class="headR"></th></tr>
    <g:each var="f" in="${list}">
     <tr>
       <td/>
       <td>${f.id}</td>
       <td>${f.dateCreated}</td>
       <td>${f.name}</td>
       <td>${f.type}</td>
       <td>${f.text}</td>
       <td/>
     </tr>
    </g:each>
    </table>
  </body>
</html>
