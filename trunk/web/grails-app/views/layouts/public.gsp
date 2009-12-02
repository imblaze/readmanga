<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang='en' xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta http-equiv="Pragma" content="no-cache"/>
      <meta http-equiv="Expires" content="-1"/>
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>ReadManga.ru - <g:layoutTitle default="" /></title>
        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <p:css name="style" />
        <g:javascript library="jquery"/>

        <script language="JavaScript" type="text/javascript" >
          var jQ = jQuery.noConflict();

          jQ(document).ready(function() {
            jQ("button").hover(function() {
              jQ(this).addClass('pretty-hover');
            }, function() {
              jQ(this).removeClass('pretty-hover');
            });
          });

          function changeSkin(name) {
            jQ("body").css('background-color', '');
            jQ("body").removeClass().addClass(name);
            <g:remoteFunction action="changeSkin" controller="remoteJS" params="'sk='+name"/>;
          }

          function setZoomOption(selected) {
            <g:remoteFunction action="setZoomOption" controller="remoteJS" params="'selected='+selected"/>;
          }

          function setBGColor(color){
            jQ("body").removeClass().css('background-color', color);
            <g:remoteFunction action="setBGColor" controller="remoteJS" params="'bgColor='+color"/>;
          }

          function saveErrorPicture(url) {
            <g:remoteFunction action="saveAlert" controller="remoteJS" params="'url='+url"/>;
          }
        </script>
        <p:javascript src="iColorPicker-noLink"/>

        <g:layoutHead />
    </head>
<body class="${cookie(name:'skin')}" style="background-color:${cookie(name: 'bgColor')}">
<div class="pageHeader">
  <div id="header">
    <div id="headerFirst">
      <div id="logo">
      <g:link controller="index" action="index" class="nonHover">
        <p:image width="300" height="45" alt="Читать мангу Online" src="logo_filled.jpg" title="ReadManga.ru -- читай мангу с удовольствием"/>
      </g:link>
      </div>
      <div id="accountMenu">
        <g:if test="${!errorPage}">
          <shiro:isLoggedIn>
            <a id="myprofile" class="mainmenu" href="/forum/user/edit/<shiro:principal property="forumId"/>.page"><g:message code="user.data"/></a> |
            <a id="logout" class="mainmenu" href="/forum/user/logout.page"><g:message code="user.logout"/> [ <shiro:principal property="username"/> ]</a>
          </shiro:isLoggedIn>
          <shiro:isNotLoggedIn>
            <a id="myprofile" class="mainmenu" href="/forum/user/insert.page"><g:message code="user.signup"/></a> |
            <a id="logout" class="mainmenu" href="/forum/user/login.page"><g:message code="user.login"/></a>
          </shiro:isNotLoggedIn>
        </g:if>
      </div>
      <div id="mangaSearch">
        <g:form name="form" controller="search" action="index" method="post">
          <g:textField name="q"/>
          <button type="submit"><g:message code="search"/></button>
        </g:form>
      </div>
      <div class="clear-content"><!----></div>
    </div>
    <div>
      <div id="navLinks">
        <g:link controller="index"><g:message code="main"/></g:link> |
        <g:link controller="manga"><g:message code="manga.list"/></g:link> |
        <a href="/forum"><g:message code="forum"/></a> |
        <g:link controller="about"><g:message code="about"/></g:link>
      </div>
      <div id="additionalMenu">
        <div id="themControl">
          <b><g:message code="theme"/>:</b>
          <g:each in="${(1..7)}">
            <button onclick="changeSkin('sk${it}');" class="skinButton skin${it}"><!----></button>
          </g:each>
          <input type="hidden" class="iColorPicker" value="#ffffff" id="bgColor"/>
        </div>
      </div>
      <div class="clear-content"><!----></div>
    </div>
  </div>
</div>


    <g:pageProperty name="page.headerContent"/>

<div class="pageBlock" id="mangaBox">

    <g:render template="/shared/topBaner"/>
  
  <g:pageProperty name="page.centerContent"/>
  <g:if test="${pageProperty(name:'page.leftContent')}">
    <div class="leftContent">
       <g:pageProperty name="page.leftContent"/>
    </div>
  </g:if>
  <g:if test="${pageProperty(name:'page.rightContent')}">
    <div class="rightContent">
       <g:pageProperty name="page.rightContent"/>
    </div>
  </g:if>
  <div class="clear-content"><!----></div>
  <g:layoutBody />
</div>
    <g:pageProperty name="page.footerContent"/>

    <div class="pageBlock" style="text-align: right;">
      <div style="text-align: center">
        <m:page name='user_agreement'>Пользовательское Соглашение</m:page> |
        <m:page name='copyright_holders'>Для правообладателей</m:page>
        <iframe src="/forum/forums/dummy.page" frameborder="no" class='cpFrame' height='15px' width='15px' scrolling='no' frameborder='0' border='0' cellspacing='0' style="display:none; visibility: hidden;"></iframe>
        <!--<img src="/forum/images/transp.gif"  WIDTH=1/>-->
      </div>
    </div>
<m:ifNotAdsense>
  <script type="text/javascript">
    var __rt = Math.round(Math.random() * 100000);
    document.write('<scr' + 'ipt language="javascript" type="text/javascript" src="http://id16050.luxup.ru/show/11882/?div=lx_11882&rt=' + __rt + '&r=' + escape(document.referrer) + '"><' + '/scr' + 'ipt>');
    __rt = Math.round(Math.random() * 100000);
    document.write('<scr' + 'ipt language="javascript" type="text/javascript" src="http://id16050.luxup.ru/show/11880/?div=lx_11880&rt=' + __rt + '&r=' + escape(document.referrer) + '"><' + '/scr' + 'ipt>');
    __rt = Math.round(Math.random() * 100000);
    document.write('<scr' + 'ipt language="javascript" type="text/javascript" src="http://id16050.luxup.ru/show/11886/?div=lx_11886&rt=' + __rt + '&r=' + escape(document.referrer) + '"><' + '/scr' + 'ipt>');
  </script>
</m:ifNotAdsense>

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-9002078-1");
pageTracker._trackPageview();
} catch(err) {}</script>

<!-- begin of Top100 code -->
<script id="top100Counter" type="text/javascript" src="http://counter.rambler.ru/top100.jcn?1792884"></script><noscript><img src="http://counter.rambler.ru/top100.cnt?1792884" alt="" width="1" height="1" border="0"/></noscript>
<!-- end of Top100 code -->
</body>
</html>
