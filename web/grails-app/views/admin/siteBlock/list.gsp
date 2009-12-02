<html>
  <head>
  </head>
 <body>
   <g:each var="b" in="${blocks}">
     <g:link action="edit" id="${b.id}">${b.name}</g:link><br>
   </g:each>
 </body>
</html>
