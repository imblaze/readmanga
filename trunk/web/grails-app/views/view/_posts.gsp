<g:if test="${posts}">
  <table class="cTable">
    <tr>
      <th class="headL"></th>
      <th width="120"></th>
      <th width="530"><g:message code="manga.comment"/></th>
      <th class="headR"></th>
    </tr>
    <g:each var="p" in="${posts}">
        <tr>
          <td/>
          <td>
            ${p.postUsername}<br>
            <span class="smallText"><m:df value="${p.time}"/></span> 
          </td>
          <td>
             ${p.text}
          </td>
          <td/>
        </tr>
    </g:each>
  <tr>
    <td/>
    <td/>
    <td><g:link action="topic" params="[name: params.name]"><g:message code="manga.discuss.read.more"/>...</g:link></td>
    <td/>
  </tr>
  </table>
</g:if>
<g:else>
  <g:link action="topic" class="button" params="[name: params.name]"><g:message code="manga.discuss"/>!!!</g:link>
</g:else>