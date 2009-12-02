<div id="twitter">
  <h5>Комментарии: <sup>Новое</sup></h5>
  %{--<g:if test="${!twitts}">--}%
  %{--</g:if>--}%
  <g:each var="tw" in="${twitts}">
    <div class="twitt" pagenumber="${tw.page}">
      <m:linkToUser user="${tw.user}"/>: ${tw.message}
      <div class="twittInfo hide">
         Created: <m:df value="${tw.dateCreated}"/>
      </div>
    </div>
  </g:each>


  <div id="addTwitt">
    <shiro:isLoggedIn>
      <script language="JavaScript" type="text/javascript">
        function updateLength(text) {
          jQ("#twittLength").text(text.length);
        }
      </script>

      <p>Максимальная длинна комментария 80 символов</p>
      <g:form controller="twitter" action="saveTwitt">
        <g:hiddenField name="page" id="twittPageNum" value="0"/>
        <g:hiddenField name="subId" value="${c?.sub?.id}"/>
        <g:hiddenField name="mature" value="${params.mature}"/>

        <p class="smallText">Текст сообщения: (длинна <span id="twittLength">0</span>)</p>
        <g:textField name="message" id="twittMessage" value="" maxlength="80" onkeyup="updateLength(this.value)" onchange="updateLength(this.value)" onfocus="h.twitterFocus();"/>
        <br/>
        <br/>
        <button type="submit">Сохранить Комментарий</button>
      </g:form>
    </shiro:isLoggedIn>
    <shiro:isNotLoggedIn>
      Зарегистрируйтесь, для написания комментария
    </shiro:isNotLoggedIn>

  </div>

</div>