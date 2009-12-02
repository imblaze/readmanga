<html>
<head>
  <meta name="layout" content="reader">
  <title>${m.name} ${c.title}</title>
  %{--<p:javascript src="jquery/jquery.ba-postmessage.min" />--}%
  <p:javascript src="scripts" />
  <script type="text/javascript">
  /*
 * postMessage - v0.4 - 8/23/2009
 * http://benalman.com/
 *
 * Copyright (c) 2009 "Cowboy" Ben Alman
 * Licensed under the MIT license
 * http://benalman.com/about/license/
 */
(function($){var g,d,j=1,a,b=this,f=!1,h="postMessage",e="addEventListener",c,i=b[h]&&!$.browser.opera;$[h]=function(k,l,m){if(!l){return}k=typeof k==="string"?k:$.param(k);m=m||parent;if(i){m[h](k,l.replace(/([^:]+:\/\/[^\/]+).*/,"$1"))}else{if(l){m.location=l.replace(/#.*$/,"")+"#"+(j++)+"&"+k}}};$.receiveMessage=c=function(l,m,k){if(i){if(l){a&&c();a=function(n){if((typeof m==="string"&&n.origin!==m)||($.isFunction(m)&&m(n.origin)===f)){return f}l(n)}}if(b[e]){b[l?e:"removeEventListener"]("message",a,f)}else{b[l?"attachEvent":"detachEvent"]("onmessage",a)}}else{g&&clearInterval(g);g=null;if(l){k=typeof m==="number"?m:typeof k==="number"?k:100;g=setInterval(function(){var o=document.location.hash,n=/^#?\d+&/;if(o!==d&&n.test(o)){d=o;l({data:o.replace(n,"")})}},k)}}}})(jQuery);

  </script>
</head>
<content tag="headerContent">
    <div class="pageBlock controlBox">
      <g:render template="control"/>
      %{--<g:render template="hint"/>--}%
    </div>
   </content>

  <content tag="centerContent">

    <h1>${m.name} ${c.title}</h1>
    <img id="mangaPicture" onclick="h.goNext();" title="<g:message code="manga.reader.page.next"/>" alt="<g:message code="manga.reader.page.next"/>"/>
    <img id="nextPicture" onclick="h.goNext();" title="<g:message code="manga.reader.page.next"/>" class="hide"/>
    <button onclick="h.goToChapter('${createLink(action:'reader', params:[name: m.linkName, num: prev?.num ?: 1, vol: prev?.vol ?: 1, mature: params.mature])}');" title="<g:message code="manga.reader.capter.prev"/>" class="prevChapLink hide"><g:message code="manga.reader.capter.prev"/></button>
    
    <g:render template="scripts"/>
</content>
</html>
