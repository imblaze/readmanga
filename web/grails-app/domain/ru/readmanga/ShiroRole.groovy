package ru.readmanga

import ru.readmanga.ShiroUser

class ShiroRole {
    String name
    public static String USER="USER"
    public static String ADMIN="ADMIN"
    public static String MODERATOR="MODERATOR"


    static hasMany = [ users: ShiroUser, permissions: String ]
    static belongsTo = ShiroUser

    static constraints = {
        name(nullable: false, blank: false, unique: true)
    }

    public String toString(){
        name
    }
}
