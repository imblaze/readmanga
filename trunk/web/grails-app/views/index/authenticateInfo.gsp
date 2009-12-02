<html>
<meta name="layout" content="main">
  <body>
  <content tag="leftContent">
    <h1>Authenticate Info</h1>

    Cookie Session Id: ${cookieSesId} <br/>
    Cookie jforumAutoLogin: ${jforumAutoLogin} <br/>
    Cookie jforumUserHash: ${jforumUserHash} <br/>
    Cookie jforumUserId: ${jforumUserId} <br/>
    Authenticated: ${authenticated} <br/>
    Name: ${name}

    User seached: ${seached} <br/>

    Forum facade: ${facade} <br/>

    User by manga cookie: ${user} (${user?.username}) <br/>

    User by forum cookie: ${cookieUser} (${cookieUser?.username}) <br/>

    Shiro info:

    <shiro:isLoggedIn>
      <shiro:principal property="username"/>  (<shiro:principal property="forumId"/>)
      <br/>
      Roles:
      <shiro:hasRole name="ADMIN">ADMIN</shiro:hasRole>
      <shiro:hasRole name="MODERATOR">MODERATOR</shiro:hasRole>
      <shiro:hasRole name="USER">USER</shiro:hasRole>
    </shiro:isLoggedIn>



  </content>

    <content tag="rightContent">

    %{--<g:link action="asoc">Create new manga</g:link><br>--}%
  </content>
  </body>
</html>