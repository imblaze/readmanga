<html>
  <head>
    <title><g:message code="feedback"/></title>
    <meta name="keywords" content="читать, манга онлайн, манга, скачать наруто, блич, naruto, bleach, переводы аниме каталог, лучшая манга, япония"/>
    <meta name="description" content="Удобное чтение манги, хороший каталог манги, Сервис чтения манги онлайн, русские переводы манги, каталог манги. Чтение онлайн переводов на русский язык самой популярной манги мира." />
    <!--<meta name="layout" content="main"/>-->
  </head>

  <content tag="leftContent">
              <h1><g:message code="feedback"/></h1>
              <p>Мы рады узнать ваше мнение и пожелания.</p>
              <p>Так же здесь вы можете сообщить нам ссылку на новый перевод манги.</p>
              <p>Если возможно, укажите любой ваш контакный адрес.</p>
              <g:form name="form" action="save" method="post"> 
                <p class="smallText">Имя (E-mail):</p>
                <g:textField name="name" class="wild"/>

                <p class="smallText">Тип:</p>
                <g:select  name="type" value="${params.type}" from="${['OPINION','SUBMISSION']}" valueMessagePrefix="feedback.type"/>

                <p class="smallText" >Текст:</p>
                <g:textArea name="text" rows="5" cols="20" class="wild"/>
                <br/>
                <br/>
                <button type="submit"><g:message code="save"/></button>
              </g:form>
    <br/>
              <p>Если хотите, загрузить к нам новую мангу, то вам <g:link controller="upload" action="chapters">сюда</g:link>.</p>
              <m:block name="upload"/>
    </content>
  <content tag="rightContent">
              Если вы хотите сообщить нам о новой манге, выберите тип <b><g:message code="feedback.type.SUBMISSION"/></b>,
              если есть вопрос или пожелание, выберите <b><g:message code="feedback.type.OPINION"/></b>. <br/>
              Если затрудняетесь с выбором, оставьте все как есть, и напишите все что хотите, ваш посыл в любом случае дойдет до адресата.
       </content>
</html>
