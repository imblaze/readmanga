<html>
<head>
  <title><g:message code="manga.read"/> - ${m.name} <g:if test="${m.engName}" >, ${m.engName}</g:if><g:if test="${m.jpName}" >, ${m.jpName}</g:if>. Всегда свежие перводы</title>
  <meta name="keywords" content="<g:message code="manga.meta.key"/> ${m.name}, <g:if test="${m.engName}" >, ${m.engName}</g:if><g:if test="${m.jpName}" >, ${m.jpName},<g:each var="gen" in="${m.genres}"> ,${gen.title}</g:each></g:if> "/>
  <meta name="description" content="<g:message code="manga.meta.description"/> <m:stripHtml value="${m.description}"/>" />
  <link rel="alternate" type="application/rss+xml" title="RSS" href="${createLink(controller:"rss",action:'manga',params:[name:m.linkName])}"/>
  <script language="JavaScript" type="text/javascript" >
    function showFullList(){
      jQ("#chaptersList .chapter").show();
      jQ("#chapterControl").hide();
    }
  </script>
</head>

  <content tag="leftContent">
    <h1><g:message code="manga"/> ${m.name}
    <g:if test="${m.engName && !m.name?.equals(m.engName)}">
      (${m.engName})
    </g:if>
    </h1>
    
    <g:if test="${m.picture}">
      <div id="mangaDescPicture" class="left">
        ${m.picture}
      </div>
    </g:if>
    <div id="mangaSettings" class="left">
      <g:if test="${m.jpName && !m.name?.equals(m.jpName) && !m.engName?.equals(m.jpName)}">
        <p>${m.jpName}</p>
      </g:if>

      <div id="mangaAction">
        <g:link action="topic" class="button" params="[name: params.name]"><g:message code="manga.discuss"/>!!!</g:link>
        <g:link controller="rss" action="manga" params="[name:m.linkName]" class="rss">RSS</g:link>
        <g:message code="system.shared.addbutton"/>
        <!-- AddThis Button BEGIN -->
        %{--<a class="addthis_button" href="http://addthis.com/bookmark.php?v=250&amp;pub=xa-4aa8c4180d448af3"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4aa8c4180d448af3"></script>--}%
        <!-- AddThis Button END -->
        <br/>
        <br/>
      </div>

      <h5><g:message code="manga.info"/>:</h5>
      <p>
        <g:if test="${!m.single}">
          <b><g:message code="manga.vols"/>:</b>
          ${m.volumeCount}</g:if><g:else><b><g:message code="manga.single"/></b></g:else><g:if test="${!m.completed}">, <g:message code="manga.continius"/></g:if>
      </p>
      <p><b><g:message code="manga.translation"/>:</b>
        <g:if test="${m.translationCompleted}"><g:message code="manga.translation.finished"/></g:if>
        <g:else><g:message code="manga.translation.continius"/></g:else>
      </p>
      <p><b><g:message code="manga.genres"/>:</b>
        <g:each var="gen" in="${m.genres}" status="i"><g:if test="${i>0}">,</g:if>
          <g:link controller="manga" action="genre" params="[id: gen.name]">${gen.title}</g:link></g:each>
      </p>
      <p><b><g:message code="manga.translaters"/>:</b>
        <g:each var="tr" in="${m.translators}" status="i"><g:if test="${i>0}">,</g:if>
          <a href="${tr.link}" target="_blank">${tr.name}</a></g:each>
      </p>
    </div>

    <div class="clear-content"><!----></div>


    <div class="mangaDescription">
      ${m.description}
      <div class="clear-content"><!----></div>
    </div>

    <br/>
    <g:render template="posts"/>
    <br/>
    <g:render template="/shared/middleBaner"/>
      <br>
     <g:if test="${m.mature}">
        <p><g:message code="manga.mature.description"/>
         <g:if test="${!params.mature}">
           <br/>
           <b><g:message code="manga.mature.is.more"/> <a href="?mature=1"><g:message code="manga.mature.press"/></a></b>
         </g:if>
         </p>
      </g:if>
     
     <g:if test="${!(m.mature && !params.mature)}">
      <table class="cTable" id="chaptersList">
        <tr>
          <th class="headL"> </th>
          <th width="515"><g:message code="manga.chapters"/></th>
          <th width="90"><g:message code="manga.chapters.added"/></th>
          <th class="headR"> </th>
        </tr>
          <g:each var="c" status="i" in="${chapters}">
            <tr class="chapter <g:if test="${i>25}">hide</g:if>">
              <td/>
              <td>
                <m:linkToChapter manga="${m}" c="${c}" mature="${params.mature}">${m.name} ${c.title}</m:linkToChapter>
              </td>
              <td><m:df value="${c.sub?.dateCreated}"/></td>
              <td/>
            </tr>
          </g:each>
          <g:if test="${chapters?.size()>25}">
            <tr id="chapterControl">
              <td/>
              <td>
                <button onclick="showFullList();">Показать весь список</button>
              </td>
              <td/>
              <td/>
            </tr>
          </g:if>
      </g:if>
      </table>
  </content>


<content tag="rightContent">
  <h5><g:message code="manga.edit"/></h5>
  <g:link controller="editor" action="editManga" params="[id: m.id]"><g:message code="manga.edit"/></g:link> <sup>Новое</sup> <br/>
  <g:link controller="upload" action="chapters" params="[manga: m.id]"><g:message code="manga.upload"/></g:link> <sup>Новое</sup> <br/>
  <br/>
  
  <g:render template="/manga/list"/>

  <br/>
  <br/>
  <g:render template="info"/>
</content>

</html>
