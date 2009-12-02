package ru.readmanga.admin
import ru.readmanga.*

class SiteBlockEditController {
    static layout = 'main'
    def index = { 
      def list = SiteBlock.list()
      render(view: "/admin/siteBlock/list", model: [blocks: list])
    }
    
    def edit = {
      def block = SiteBlock.get(params.id)
      render(view: "/admin/siteBlock/edit", model: [b: block])
    }

    def save = {
      def block = SiteBlock.findByName(params.name)
      block.properties = params
      block.save()
      redirect(action: index)
    }


}
