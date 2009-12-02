<html>
<meta name="layout" content="main">
  <body>
  <content tag="leftContent">
    <h1>Site Configuration</h1>

    ${message}<br/>
    <g:form name="editConfig" url="[action:'save']">
      <g:checkBox name="adsense" value="${adsense}"/> Adsense
      <br/>
      <g:submitButton name="Save"/>
    </g:form>
  </content>

    <content tag="rightContent">

    <g:link controller="index" action="authenticateInfo">Authenticate Info</g:link>
  </content>
  </body>
</html>
