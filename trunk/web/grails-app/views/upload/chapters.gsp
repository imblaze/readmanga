<html>
  <head>
    <title><g:message code="manga.upload.title"/></title>
    <meta name="keywords" content="<g:message code="manga.upload.meta.key"/>"/>
    <meta name="description" content="<g:message code="manga.upload.meta.description"/>" />
    <script type="text/javascript">
      function showNextRow(val, num){
        if (val && val.length>0){
          jQ("#row_"+(num+1)).show();
        }
      }
    </script>

  </head>

<content tag="leftContent">



  <h1><g:message code="manga.upload.title"/></h1>

  <p><g:message code="manga.upload.thx"/></p>
  <g:if test="${flash.messages}">
    <div class="message">
      <g:each in="${flash.messages}" var="message">
        <g:message code="${message}"/><br/>
      </g:each>
    </div>
  </g:if>
    <g:uploadForm controller="upload" method="post" action="chapters">
      <g:message code="manga"/>: <g:select name="manga" from="${mangas}" optionValue="engName" optionKey="id" value="${curId}"/><br/>
      %{--<g:message code="manga.translation"/>: <g:select name="translater" class="hide" from="${trans}" optionValue="name" optionKey="id" value="${translater}" noSelection="['0':'---']"/>--}%
      <br/>
      <br/>
      <g:each in="${(1..10)}">
        <span id="row_${it}" <g:if test="${it>1}">class="hide"</g:if>>
          <g:message code="manga.vol"/>: <input type="text" name="vol${it}" class="number" onchange="showNextRow(this.value, ${it});"/>
          <g:message code="manga.chapter"/>: <input type="text" name="chapter${it}" class="number" onchange="showNextRow(this.value, ${it});"/>
          <input type="file" name="file${it}" onchange="showNextRow(this.value, ${it});"/>  <br/>
        </span>
      </g:each>
      <br/>
      <button type="submit"><g:message code="manga.upload"/></button>
    </g:uploadForm>

</content>
<content tag="rightContent">
  <g:message code="manga.upload.description"/>

  %{--<g:render template="/view/info"/>--}%

</content>
</html>



