<html>
<head>
  <title>Чтение манги ${m.name} часть ${c.title} - свежие переводы. Read manga online! Страниц - ${pSize} </title>
  <meta name="description" content="Здесь вы можете прочитать мангу ${m.name} часть ${c.title}. Всего страниц ${pSize}. Легко и удобно читать. Вся манга рунета" />
  <p:javascript src="scripts" />
  <!--//todo add hidden to store the state during reload-->
  <style type="text/css">
    #mangaBox {text-align:center; }
    .pageBlock, #header{width:850px;}
    h1{font-size:1.7em}
    #additionalMenu {width:500px}
    #accountMenu{width:280px}
    #topBaner{margin-left:0}
  </style>
</head>
  <content tag="headerContent">
    <div class="pageBlock">
      <g:render template="control"/>
      
      <g:render template="hint"/>
    </div>
   </content>
    <!--<button>bookmark</button>-->
  <content tag="centerContent">

    <h1>
      <g:link action='index' params='[name: m.linkName]'>${m.name}</g:link> ${c.title}
    </h1>

    <img id="mangaPicture" onclick="h.goNext();" title="<g:message code="manga.reader.page.next"/>" alt="<g:message code="manga.reader.page.next"/>"/>
    <img id="nextPicture" onclick="h.goNext();" title="<g:message code="manga.reader.page.next"/>" class="hide"/>
    <g:if test="${prev}">
      <g:link action='chapter' params='[name: m.linkName, num: prev?.num ?: 1, vol: prev?.vol ?: 1, mature: params.mature]' class='hide prevChapLink'><g:message code="manga.reader.capter.prev"/></g:link>
    </g:if>
    <g:else>
      <g:link action='index' params='[name: m.linkName]' class='hide prevChapLink'><g:message code="manga.reader.page.go"/> "${m.name}"</g:link>
    </g:else>
  </content>

   <content tag="footerContent">
    <div class="pageBlock">
      <g:render template="control"/><br/>
      <g:render template="twitter"/>
    </div>

    <g:render template="scripts"/>
   </content>

</html>
