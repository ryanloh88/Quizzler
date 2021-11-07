//
//  QuizData.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 22/10/21.
//

import Foundation

struct QuizData: Decodable{
    let results: [Results] //need to index the question
    
}
struct CatData :Decodable{
    let category_question_count : QuestionNum
}
struct QuestionNum : Decodable{
    let total_easy_question_count: Int
    let total_medium_question_count: Int
    let total_hard_question_count:Int
    
}
struct Results: Decodable{
    let category : String
    let type : String
    let difficulty : String
    let question : String
    let correct_answer : String
    let incorrect_answers: [String] //need to index the 3 questions
}
struct WrongAnswer : Decodable{
}
