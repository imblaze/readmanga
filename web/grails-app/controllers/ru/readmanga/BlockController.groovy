package ru.readmanga

class BlockController {
    static layout = 'public'
    def index = {
      def block = SiteBlock.findByName(params.name)
      if(block)
        return render(view: 'block', model: [b: block])
      else
        return render(status: 404, view: "error/error404")
    }
}
