<h5>Последние комментарии: <sup>Новое</sup></h5>
<div id="lastTwitts">
  <g:each var="tw" in="${lastTwitts}">
    <div class="twitt">
      <m:linkToUser user="${tw.user}"/>:
        <m:linkToChapter c="${tw.sub.chapter}" mature="${params.mature}" page="${tw.page}" hideNew="${true}">${tw.message}</m:linkToChapter>
    </div>
  </g:each>
</div>
