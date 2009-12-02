class UrlMappings {
    static excludes = ["/images/*", "/css/*", "/js/*", "/google*"]

    static mappings = {
      "/"(controller:"index", action: "index")
      "/page/$name"(controller:"block", action: "index")

      "/$name" (controller: "view", action: "index")
      "/$name/topic" (controller: "view", action: "topic")
      "/$name/vol$vol/$num"(controller: "view", action: "chapter")
      "/reader/$name/vol$vol/$num"(controller: "view", action: "reader")
      "/editor/$action" (controller: "editor")
      "/twitter/$action" (controller: "twitter")


      "/about/$name?" (controller: "about", action: "index")
      "/ajax/$action" (controller: "remoteJS")
      "/search" (controller: "search", action: "index")

      "/feedback/$action" (controller: "feedback")
      "/genre/$id/$lang?"(controller: "manga", action: "genre")
      "/list/$lang?/"(controller: "manga", action: "index")
      "/rss/$action?"(controller: "rss")
      "/upload/$action?" (controller: "upload")

      "/error/$action"(controller:"error")
      "/adsense/$action" (controller:"advertisement")
      "/sitemap"(controller:"index", action:"sitemap")
      "/info/authenticateInfo"(controller:"index", action:"authenticateInfo")

      "/admin"(controller:"submission")

      // admin

      "/admin/translator/$action?/$id?" (controller:"translatorWidget")
      "/admin/config/$action?" (controller:"configuration")
      "/admin/genres/$action?" (controller:"genres")
      "/admin/twitts/$action?" (controller:"twitts")
      "/admin/translators/$action?" (controller:"translators")
      "/admin/users/$action?" (controller:"users")
      "/admin/genre/$action?" (controller:"genre")
      "/admin/siteBlocks/$action?" (controller:"siteBlockEdit")
      "/admin/moderation/$action?" (controller:"moderation")
      "/admin/submission/$action?/$id?" (controller:"submission")
//      "/admin/$controller/$action?/$id?" {
//	      constraints {
//			 // apply constraints here
//              }
//	  }
 
      "500"(controller: "error", action: "index")
      "404"(controller: "error", action: "error404")
	}
}
