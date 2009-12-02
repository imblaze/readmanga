import org.mortbay.jetty.webapp.WebAppContext

eventConfigureJetty = { server ->
  def context = 
   new WebAppContext(war: "../forum/dist/jforum-2.1.8.war", 
                     contextPath: "/forum")
  server?.addHandler(context)
}

eventCompileStart = {kind ->
  def url = new File('../sharedMap/build/sharedMap.jar').toURI().toURL()
  this.class.getClassLoader().getRootLoader().addURL(url)
  //rootLoader.addURL(url)
}


