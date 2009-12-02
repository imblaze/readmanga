<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang='en' xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <meta http-equiv="Pragma" content="no-cache"/>
      <meta http-equiv="Expires" content="-1"/>
      <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>ReadManga.ru ADMIN:  <g:layoutTitle default="Grails" /></title>
        <p:css name="style" />

        <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
    </head>
<body>

<div class="pageHeader">
  <div id="header">
    <div id="headerFirst">
      <div id="logo">
      <g:link controller="index" action="index">
        <p:image width="300" height="45" alt="ReadManga.ru" src="logo_filled.jpg" title="ReadManga.ru -- читай мангу с удовольствием"/>
      </g:link>
      </div>
      <div id="accountMenu">
        <g:if test="${flash.hasBeenFiltered}">*</g:if>
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
        <g:link controller="submission">Мain</g:link> |
        <g:link controller="submission" action="listManga">Manga</g:link> |
        %{--<g:link controller="submission" action="listFeedback"><g:message code="feedback"/></g:link> |--}%
        <g:link controller="siteBlockEdit">Blocks</g:link> |
        <g:link controller="users">Users</g:link>
      </div>
      <div id="additionalMenu">
        <g:link controller="configuration">Configuration</g:link> |
        <g:link controller="moderation">Moderation</g:link> |
        <g:link controller="twitts">Твиты</g:link>
      </div>
      <div class="clear-content"><!----></div>
    </div>
  </div>
</div>


    <g:pageProperty name="page.headerContent"/>

<div class="pageBlock" id="mangaBox">

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


</body>
</html>
