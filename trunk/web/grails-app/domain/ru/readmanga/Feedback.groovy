package ru.readmanga
enum FeedbackType {
  OPINION(1), SUBMISSION(2)
  final int id
  FeedbackType(int id) { this.id = id }
 
}

class Feedback {
    String name;
    String text;
    FeedbackType type;
    Date dateCreated
    static constraints = {
      text(maxSize:10000)
    }
}
