package ru.readmanga
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication

class ErrorController {
    static layout = 'public'
    def index = {
//      if (exception){
//         println "Exception Message"+exception.message
//         println "Caused by: "+exception.cause?.message
//         println "Class: "+exception.className
//         println "At Line: "+exception.lineNumber
//      }
      if (params){
         println "Parameters: ${params}"
      }
      render(view: 'error', model: [notProd: GrailsUtil.environment != GrailsApplication.ENV_PRODUCTION, errorPage:true])
    }

    def error404 = {
      render(view: 'error404')
    }
} 
