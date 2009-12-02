<button onclick="h.onResize(true);" class="resize" title="<g:message code="manga.reader.resize.title"/>"></button>
  <g:select from="${chapters}" optionKey="${{createLink(action:(reader?'reader':'chapter'), params:[name: m.linkName,num:it.num, vol:it.vol, mature: params.mature])}}"
        optionValue="title" onchange="h.goToChapter(this.value);"
        value="${createLink(action:(reader?'reader':'chapter'), params:[name: m.linkName,num:c.num, vol:c.vol, mature: params.mature])}" id="chapterSelectorSelect"/>

<button onclick="h.goPrev(true);" class="prevButton" title="<g:message code="manga.reader.prevButton.title"/>">←</button>
<g:message code="manga.chapter.page"/> <g:select from="${1..pSize}" onchange="h.goPage(this.value, true);" optionKey="${{it-1}}" class="pageSelector"/>
<g:message code="of"/> ${pSize}
<button onclick="h.goNext(true);" class="nextButton" title="<g:message code="manga.reader.nextButton.title"/>">→</button>
%{--<g:link action="topic" class="button forumButton" params="[name: m.linkName]" target="_blank"><g:message code="manga.discuss"/></g:link>--}%
<g:link class="goToReadmanga" controller="index" target="_blank"><p:image src="inner_baner.gif" alt="${message('manga.reader.open.site')}" title="${message('manga.reader.open.site')}"/></g:link>
<p:image class="mangaProgress" src="spinner.gif" title="${message('manga.loading')}" alt="${message('manga.loading')}"/>

