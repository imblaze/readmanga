<html>
  <head>
    <title><g:message code="main.title"/></title>
    <meta name="keywords" content="<g:message code="main.keywords"/>"/>
    <meta name="description" content="<g:message code="main.description"/>" />
    %{--    
    <link rel="alternate" type="application/rss+xml" title="RSS" href="${createLink(controller:"rss",action:'index')}"/>
    <feed:meta kind="atom" version="1.0" controller="index" action="latestRss" params="[format:'atom']"/>--}%
  </head>
<content tag="leftContent">
  <div>
    <h1><g:message code="main.welcom"/></h1>
    <m:block name="welcome"/>
    <h5><g:message code="main.news"/></h5>
    <m:block name="news"/>
  </div><br/>

  <h5><g:message code="main.last.new"/></h5>
  <table class="cTable">
    <tr>
      <th class="headL"></th>
      <th width="515"><g:message code="name"/></th>
      <th width="90"><g:message code="date"/></th>
      <th class="headR"></th>
    </tr>
    <g:each var="s" in="${list}">
      <g:set var="c" value="${s.chapter}"/>
      <tr>
        <td/>
        <td>
          <m:linkToChapter c="${c}" mature="${params.mature}" hideNew="${true}">${c.manga.name} ${c.title}</m:linkToChapter>
        </td>
        <td>
          <m:df value="${s.dateCreated}"/>
        </td>
        <td/>
      </tr>
    </g:each>
    <tr>
      <td/>
      <td colspan="2" style="text-align: center;">
        <span class="pagination">
          <g:paginate total="$total" prev="←" next="→" max="30" maxsteps="8"/>
        </span>
      </td>
      <td/>
    </tr>
  </table>

</content>
<content tag="rightContent">
  <g:render template="/manga/list"/>
  <br/>
  <br/>
  Подписка: <g:message code="system.shared.feedburner"/><br/>
  <br/>
  <g:message code="system.shared.addbutton"/><br/>

  <g:render template="lastTwitts"/>    <br/>
  <g:render template="/shared/rightBaner"/>
  <g:render template="statInfo" model="${stat}"/>
  <g:render template="/manga/genres"/>
  <br/>
</content>

<body>
  <br/>
  
  </body>

</html>
