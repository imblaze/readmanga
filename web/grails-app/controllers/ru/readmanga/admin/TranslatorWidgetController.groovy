package ru.readmanga.admin

import ru.readmanga.*
import grails.converters.JSON

class TranslatorWidgetController {
  def add = {
    switch(params.subAction) {
      case 'add' :
        def t = new Translator(params)
        if(!t.save())
          println(t.errors)
        render(template: '/admin/trans/translators', model: [trans: Translator.list(sort:'name'), current: t?.id])
        break
      case 'update':
        def t;
        if(params.id) {
          t = Translator.get(params.id)
          t.properties = params;
          if(!t.save())
             println(t.errors)
        }

        render(template: '/admin/trans/translators', model: [trans: Translator.list(sort:'name'), current: t?.id])
        break;
    }
  }

  def get = {
    if(params.id)
      render(Translator.get(params.id) as JSON)
    else
      render("{name:'', link:'', id:''}")
  }

  def addTo = {
    def m = Manga.get(params.mangaId)
    def t = Translator.get(params.translatorId)
    m.addToTranslators(t)
    m.save()
    render(template: '/admin/trans/showTranslators', model:[mangaTrans: m.translators, m:m])
  }

  def del = {
    def m = Manga.get(params.mangaId)
    def t = Translator.get(params.id)
    m.translators.remove(t)
    m.save()
    render(template: '/admin/trans/showTranslators', model:[mangaTrans: m.translators, m:m])
  }
}
