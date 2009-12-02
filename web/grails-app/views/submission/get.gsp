<html>
<meta name="layout" content="main">
  <body>
    <h1>Submission id=${sub.id}</h1>
    <g:each in="${sub.pages}">
     <p><img src="${sub.location.prefix+ it.url}" width="${it.w}" height="${it.h}"></p>
    </g:each>
  </body>
</html>
