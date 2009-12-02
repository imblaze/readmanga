package ru.readmanga

class Twitt {
    ShiroUser user
    String message
    Submission sub
    int page
    Date dateCreated

    static belongsTo = Submission

    static constraints = {
        message(maxSize:250)
    }
}
