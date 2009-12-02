package ru.readmanga

class AboutController {
    static layout = 'public'
    def index = {
        render(view: params.name ?: 'index')
    }
}
