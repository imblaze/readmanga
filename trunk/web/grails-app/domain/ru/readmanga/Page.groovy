package ru.readmanga

enum ImageType {PNG, JPEG, GIF}
class Page {
    String url
    int size
    ImageType type
    int w
    int h
    String md5
    Submission submission
    static belongsTo = [Submission]
    static constraints = {
    }
}
