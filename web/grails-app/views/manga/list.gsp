<html>
<head>
  <title>
    <g:if test="${genre}">
      Список манги на сайте. Жанр ${genre.title}. Найди мангу по душе.
    </g:if>
    <g:else>
      <g:message code="manga.dir.title"/>
    </g:else>
    <g:if test="${params.sortType=='RATING'}">
      Сортировка по популярности.
    </g:if>
  </title>
  <meta name="description" content="<g:message code="manga.dir.meta.desc"/>" />
</head>

<content tag="leftContent">
  <a name="pageTop"></a>
  <g:def var="curAction" value='${genre?"genre":"index"}' />
  <h1><g:message code="manga.dir.h1"/>
    <g:each var="lang" in="['ru', 'us', 'jp']">
      <g:link action="${curAction}" params="[id: params.id, lang: lang, sortType:params.sortType]"><p:image src="flags/${lang}.gif" alt="Показывать названия на ${lang}"/></g:link>
    </g:each>
  </h1>

  <g:if test="${genre}">
    <h5><g:message code="genre"/>: ${genre.title}</h5>
  </g:if>
  
  <g:if test="${params.sortType!='RATING'}">
    <g:render template="grouped"/>
  </g:if>
  <g:else>
    <div class="margin-left">
      <ol style="font-size:15px">
        <g:each var="m" in="${list}">
          <li><m:linkToManga manga="${m}">${m.getName(params.lang)}</m:linkToManga></li>
        </g:each>
      </ol>
    </div>
  </g:else>

</content>
  <content tag="rightContent">
    <g:message code="system.shared.addbutton"/><br/>
    
    <h5><g:message code="sort"/></h5>
    <p>
    <g:if test="${params.sortType!='RATING'}">
        <g:link action="${curAction}" params="[id: params.id, lang: lang, sortType:'RATING']"><g:message code="manga.sort.type.RATING"/></g:link>
    </g:if>
    <g:else>
        <g:link action="${curAction}" params="[id: params.id, lang: lang, sortType:'']"><g:message code="manga.sort.type.ALPHABET"/></g:link>
    </g:else>
    </p>
      <g:render template="/manga/genres"/>
    <br/>
      <g:render template="/view/info"/>
  </content>
</html>
