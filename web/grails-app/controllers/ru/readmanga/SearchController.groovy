package ru.readmanga

class SearchController {
    static layout = 'public'
    def searchService
    def index = {
      def q=params.q?:""
      def results =searchService.search(q)
      render(view:'index', model: results)
    }
}
