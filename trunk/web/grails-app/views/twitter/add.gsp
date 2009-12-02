<html>
<head>
  <title>Твикни свои впечатления !!! Поделись ими со всеми</title>
  <script language="JavaScript" type="text/javascript" >
    function updateLength(text){
      jQ("#twittLength").text(text.length);
    }
  </script>        
</head>

  <content tag="leftContent">
    <h1>Добавление твика к манге "${m?.name}"</h1>
    <br/>
    <p>Максимальная длинна твика 80 символов</p>
      <g:form action="saveTwitt">
        <g:hiddenField name="subId" value="${params.subId}"/>
        <g:hiddenField name="mangaId" value="${params.mangaId}"/>
        <g:hiddenField name="page" value="${params.page}"/>
        <g:hiddenField name="mature" value="${params.mature}"/>        
        <p class="smallText">Текст сообщения: (длинна <span id="twittLength">0</span>)</p>
                <g:textField name="message" id="twittMessage" value="" onkeyup="updateLength(this.value)" onchange="updateLength(this.value)"/>
        <br/>        
        <br/>        
        <button type="submit">Сохранить Твик</button>
      </g:form>

    <br/>
    <br/>

  </content>
<content tag="rightContent">
     Твик -- это короткий текст, выражающий ваши мысли или эмоции.
  Делитесь ими с другими чтателями манги.
</content>

</html>
