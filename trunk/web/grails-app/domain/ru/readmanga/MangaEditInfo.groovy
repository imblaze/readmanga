package ru.readmanga

class MangaEditInfo {
    Manga manga   //todo not delete manga during deleting
    String name
    String engName
    String jpName
    String description
//    String picture
    boolean completed = false
    boolean translationCompleted = false
    boolean single = false
    boolean mature = false
    int volumeCount = 1
    ShiroUser user

    static constraints = {
        name(nullable: true)
//      picture(nullable: true)
        jpName(nullable: true)
//        engName(unique: true)
        description(nullable: true, maxSize: 10000)
    }
}
