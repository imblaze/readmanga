<h5><g:message code="manga.genres.list"/></h5>
    <ul class="genresList">
      <li><g:link controller="manga" action="index" params="[lang: params.lang, sortType:params.sortType]">Все</g:link></li>
      <g:each var="genre" in="${genres}">
        <li><g:link controller="manga" action="genre" params="[id: genre.name, lang: params.lang, sortType:params.sortType]">${genre.title}</g:link></li>
      </g:each>
    </ul>