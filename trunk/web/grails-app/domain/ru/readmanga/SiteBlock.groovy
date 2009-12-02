package ru.readmanga

class SiteBlock {
    String name
    String body
    static constraints = {
      body(maxSize:100000)
    }
}
