<g:render template="letters"/>

<div class="margin-left">
  <g:each var="g" in="${grouped}">
    <div class="alpha-anchor">
      <a name="${g.key}"></a>${g.key}  <a href="#pageTop">↑</a>
    </div>
    <div class="manga-group">
      <g:each var="m" in="${g.value.sort{it.getName(params.lang)}}">
        <m:linkToManga manga="${m}">${m.getName(params.lang)}</m:linkToManga>
        <br/>
      </g:each>
    </div>
  </g:each>
</div>

<br/>
<g:render template="letters"/>
