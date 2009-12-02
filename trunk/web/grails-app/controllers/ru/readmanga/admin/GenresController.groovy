package ru.readmanga.admin
import ru.readmanga.*
import org.apache.shiro.grails.annotations.RoleRequired

@RoleRequired("USER")
class GenresController {
    static layout = 'main'
    def scaffold = Genre
}
