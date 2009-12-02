<script type="text/javascript">
  var pics = ${pics};
  var prevLink = ${prev!=null};
  var nextLink = ${next!=null};
  var nextChapterLink = "<g:if test="${next}">${createLink(action:(reader?'reader':'chapter'), params:[name: m.linkName, num: next?.num ?: 1, vol: next?.vol ?: 1, mature: params.mature])}</g:if>";
  var cur11 = 0;
  var ads = "<iframe class='cpFrame' height='92px' width='730px' scrolling='no' frameborder='0' border='0' cellspacing='0' src='${createLink(controller:"advertisement", action:(reader?'external':'top'))}'></iframe>"

  function sendExternalSize(divH, w) {
  <g:if test="${reader}">
    try {
      jQ.postMessage({ if_height: divH + 195, if_width: w }, h.parent_url, parent);
    } catch(e) {
    }
  </g:if>
  }

  function sendURL(path) {
  <g:if test="${reader}">
    try {
      jQ.postMessage({ if_url: path }, h.parent_url, parent);
    } catch(e) {
    }
  </g:if>
  }
  
  h.init(pics, ${page}, ${reader?"true":"false"},${cookie(name:'zoomSelected')=="true"?"true":"false"});

</script>