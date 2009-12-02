package ru.readmanga

class Translator {
    String link
    String name
    static constraints = {
      name(unique:true)
    }

    public String toString(){
        name
    }
}
