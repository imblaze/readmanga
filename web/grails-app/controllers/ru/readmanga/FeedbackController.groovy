package ru.readmanga

class FeedbackController {
    static layout = 'public'
    def index = {
    }

    def save = {
      def feedback = new Feedback(params)
      if(!feedback.save())
        println feedback.errors
    }
}
