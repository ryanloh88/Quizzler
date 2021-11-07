//
//  QuizBrain.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/10/21.
//

import Foundation

class QuizBrain {
    var numOfCurrentQn = 0
    var totalNum = 0 
    var questionNumber = 0
    var score = 0
    var previousQuestions:[Int] = []
    var questionBank : [Question] = []
    
    let quizCategory = ["general knowledge":9, "books":10 , "film":11, "music":12, "music and theatres":13, "television":14, "video games":15, "board games":16, "science and nature":17, "computers":18, "math":19, "mythology":20, "sports":21, "geography":22, "history":23, "politics":24, "art":25, "celebrities":26, "animals":27, "vehicles":28, "comics":29, "science gadgets":30, "japanese anime and manga":31, "cartoon and animations":32]
    
    let quizCategories = ["general knowledge","books","film", "music", "music and theatres", "television", "video games", "board games", "science and nature", "computers", "math", "mythology", "sports", "geography", "history", "politics", "art","celebrities","animals","vehicles","comics","science gadgets", "japanese anime and manga", "cartoon and animations"]
    
    func getChoices(choice : Int) -> String{
        switch choice {
        case 0:
            return questionBank[questionNumber].a
        case 1:
            return questionBank[questionNumber].b
        case 2:
            return questionBank[questionNumber].c
        case 3:
            return questionBank[questionNumber].ans
        default:
            return "error"
        }
    }

   

 
    func checkAnswer(answer: String) -> Bool{
        if questionBank[questionNumber].ans.lowercased() == answer{
            return true
        }else{
            return false
        }
    }
    func getAnswerText() -> String {
        return questionBank[questionNumber].ans
    }
    func getQuestionText() -> String{
        return questionBank[questionNumber].q
    }
    func changeQuestion(){
        if previousQuestions.contains(questionNumber){
            if previousQuestions.count == questionBank.count{
                previousQuestions = []
            }
            while previousQuestions.contains(questionNumber){
                questionNumber = Int.random(in:0...(questionBank.count - 1))
            }
        }else{
            print(questionBank.count)
            questionNumber = Int.random(in:0...(questionBank.count - 1))
        }
        previousQuestions.append(questionNumber)
    }

}
