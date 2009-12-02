<h1>Translators <g:link controller="translators">(Edit)</g:link></h1>

      %{--<g:render template="/admin/trans/addTranslator"/>--}%
      <g:formRemote name="addTranslatorToManga" url="[action: 'addTo', controller: 'translatorWidget']" update="mangaTransList">
        <g:select name="translatorId" from="${trans}" optionValue="name" optionKey="id" noSelection="['':'-Choose translator-']"/>
         <input type="hidden" name="mangaId" value="${m.id}">
         <button type="submit" >Add to Manga</button>
     </g:formRemote>
     <div id="mangaTransList">
       <g:render template="/admin/trans/showTranslators"/>
     </div>
