<html>
<head>
  <title><g:message code="manga.search.title"/></title>
    %{--<g:javascript library="jquery"/>--}%
</head>

  <content tag="leftContent">
    <h1><g:message code="manga.search.h1"/></h1>

    <div id="searchBox">
      <g:form name="form" action="index" method="post"> 
                <p class="smallText"><g:message code="search.for"/>:</p>
                <g:textField name="q" value="${q}"/>

                <button type="submit"><g:message code="search"/></button>
              </g:form>

%{--Search: <g:remoteField name="searchBox" update="resultPanel" paramName="q" url="[controller:'search', action:'index']" />--}%
    </div>
    <br/>
    <br/>
    <div id="resultPanel">
      <div id="mangaResults">
        <g:if test="${mangaResults}">

          <table class="cTable">
            <tr>
              <th class="headL"></th>
              <th width="615"><g:message code="manga.search.found"/></th>
              <th class="headR"></th>
            </tr>
            <g:each in="${mangaResults}" var="m">
              <tr>
                <td/>
                <td>
                  <m:linkToManga manga="${m}" >${m.engName} / ${m.name} / ${m.jpName}</m:linkToManga>
                </td>
                <td/>
              </tr>
            </g:each>
          </table>

        </g:if>
        <g:else>
          <p><g:message code="manga.search.not.found"/></p>
        </g:else>
      </div>
    </div>


  </content>
<content tag="rightContent">
     <g:render template="/manga/list"/>
</content>

</html>
