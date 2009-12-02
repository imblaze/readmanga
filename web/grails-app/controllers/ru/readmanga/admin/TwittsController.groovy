package ru.readmanga.admin

import ru.readmanga.*
import org.apache.shiro.grails.annotations.RoleRequired

@RoleRequired("ADMIN")
class TwittsController {
    static layout = 'main'
    def scaffold = Twitt
}
