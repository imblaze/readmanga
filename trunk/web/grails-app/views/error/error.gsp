 

<html>
  <head>
    <title>Ошибка =)</title>
    <meta name="layout" content="public"/>
  </head>

<content tag="leftContent">
  <h1>Ой, ой, у нас ошибка</h1>
  <p:image alt="Ошибка на странице" src="404.jpg" title="Ошибка на странице"/>
  <br/>
  Спокойно! Логи записаны. Все будет исправлено.

  <g:if test="${notProd}">
    <div class="message">
      <strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
      <strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
      <strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
      <g:if test="${exception}">
        <strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br/>
        <strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br/>
        <strong>Class:</strong> ${exception.className} <br/>
        <strong>At Line:</strong> [${exception.lineNumber}] <br/>
        <strong>Code Snippet:</strong><br/>
        <div class="snippet">
          <g:each var="cs" in="${exception.codeSnippet}">
            ${cs?.encodeAsHTML()}<br/>
          </g:each>
        </div>
        <h2>Stack Trace</h2>
        <div class="stack">
          <pre><g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each></pre>
        </div>
      </g:if>
    </div>
  </g:if>
</content>
<content tag="rightContent">
  <a href="/forum/forums/show/11.page">Сообщить об ошибке</a>
</content>
</html>
