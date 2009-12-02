package ru.readmanga

class RemoteJSController {
    def cookieService

    def index = { }
    def changeSkin= {
       cookieService.setCookieValue(request,response,'skin',params.sk)
       cookieService.setCookieValue(request,response,'bgColor',"")
       render("done");
    }

    def saveAlert={
      def alert = new Alert(message: "wrong picture url: " + params.url)
      if(!alert.save()){
        println alert.errors
      }
      render("done");
    }
  
    def setBGColor={
      cookieService.setCookieValue(request, response, 'skin', '')
      cookieService.setCookieValue(request, response, 'bgColor', params.bgColor)
      render("done");
    }

    def setZoomOption={
      cookieService.setCookieValue(request, response, 'zoomSelected', params.selected)
      render("done");
    }




}
