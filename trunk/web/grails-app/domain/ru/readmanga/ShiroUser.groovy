package ru.readmanga
class ShiroUser {
    String username
    int forumId
    Translator trans
    static hasMany = [ roles: ShiroRole, permissions: String ]

    static constraints = {
        username(nullable: false, blank: false)
        trans(nullable: true)
        forumId(unique: true)
    }
}
