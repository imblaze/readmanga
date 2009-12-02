package ru.readmanga

class Book {
    String name
    String link
    static belongsTo = [manga: Manga]
    static constraints = {
    }
}
