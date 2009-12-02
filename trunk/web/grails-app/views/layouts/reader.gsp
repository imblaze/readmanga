<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang='en' xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta http-equiv="Pragma" content="no-cache"/>
      <meta http-equiv="Expires" content="-1"/>
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>ReadManga.ru: <g:layoutTitle default="Grails" /></title>
        <p:css name="reader" />
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

          function setZoomOption(selected) {
            <g:remoteFunction action="setZoomOption" controller="remoteJS" params="'selected='+selected"/>;
          }

          function saveErrorPicture(url) {
            <g:remoteFunction action="saveAlert" controller="remoteJS" params="'url='+url"/>;
          }
        </script>
        <g:layoutHead />
    </head>
<body>

<g:pageProperty name="page.headerContent"/>

<div class="pageBlock" id="mangaBox">
  <g:render template="/shared/externalBaner"/>
  <g:pageProperty name="page.centerContent"/>
</div>

<g:pageProperty name="page.footerContent"/>

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
