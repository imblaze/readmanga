package ru.readmanga.admin
import ru.readmanga.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import common.api.SharedMap
import org.apache.shiro.SecurityUtils

class ConfigurationController {
    def cookieService
    def index = {
        [adsense:CH.config.manga.advertisement.google, message:params.message]
    }

    def save = {
        CH.config.manga.advertisement.google=params.adsense
        redirect(action: 'index', params: [message: "Saved"])
    }

}
