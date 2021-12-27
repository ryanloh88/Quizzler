//
//  Quiz.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/10/21.
//

import Foundation
struct Question {
    let q : String
    let a: String
    let b:String
    let c:String
    let ans:String
    let category : String
    let type : String
    let difficulty : String
}
class Amount {
    
    var easyQn : Int
    var mediumQn : Int
    var hardQn : Int
    var cat = "nil"
    init(easy: Int, medium: Int, hard: Int){
        self.easyQn = easy
        self.mediumQn = medium
        self.hardQn = hard
    }
}
class Difficulty {
    var diff : String
    init(difficulty: String){
        self.diff = difficulty
    }
}
