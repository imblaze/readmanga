import org.apache.shiro.SecurityUtils
class PermissionsTagLib {
  static namespace = "p"
  def forumId={ attrs, body ->
      out<< SecurityUtils.subject?.forumId
  }

  def isLoggedIn={attrs, body ->
    if (request?.user?.id>0){
      out<<body()
    }
  }

  def notLoggedIn={attrs, body ->
    if (!(request?.user?.id>0)){
      out<<body()
    }
  }


  def isTranslater = {attrs, body ->
    if (request?.user?.id > 0 && request.session?.settings?.trans) {
          out << body()
    }
  }
}
