package ru.readmanga

class Genre {
  String name
  String title
    
  String toString() {
    "Genre{id=${id}, name=${name}}"
  }

  String getTitle(){
    title?: name
  }
}
