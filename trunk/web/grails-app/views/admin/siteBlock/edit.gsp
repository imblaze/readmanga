<html>
  <head>
  </head>
 <body>
    <g:form name="siteBlock" action="save">
      <input type="hidden" name="name" value="${b.name}">
      <fckeditor:editor
       name="body"
       width="800"
       height="400"
       toolbar="Standard"
       fileBrowser="default">
       ${b.body}
     </fckeditor:editor> 
     <button type="submit">Save</button>
   </g:form>
 </body>
</html>
