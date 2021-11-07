//
//  QuizManager.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 22/10/21.
//

import Foundation



struct QuizManager {
    
    var amount = Amount(easy: 0, medium: 0, hard: 0)
    var number = 0
    let quizURL = "https://opentdb.com/api.php?&encode=base64"
    let catLink = "https://opentdb.com/api_count.php?"
    let currentDiff = Difficulty(difficulty: "any")
    
    func fetchAmount(cat: Int) {
        let urlString = "\(catLink)category=\(cat)"
        performRequest(with: urlString, mainContent: false)
    }
    func getNum(diff:String) -> Int {
        if diff == "easy"{
            if amount.easyQn > 20 {
                return 20
            }else{
                return amount.easyQn - 1 //minus 4 because of mythology & math category db gives a wrong number
            }
        }else if diff == "medium"{
            if amount.mediumQn > 20 {
                return 20
            }else{
                return amount.mediumQn - 1
            }
        }else if diff == "hard" {
            if amount.hardQn > 20 {
                return 20
            }else{
                return amount.hardQn - 1 //math hard db category gives wrong number
            }
        }else{
            return 20 
        }
    }
    
    func fetchQuiz(category: Int , difficulty:String){
        
        if difficulty == ""{
            let urlString = "\(quizURL)&category=\(category)&amount=\(20)"
            
            currentDiff.diff = "any"
            performRequest(with: urlString, mainContent: true)
        }else{
            if difficulty == "easy" {
                let urlString = "\(quizURL)&category=\(category)&difficulty=\(difficulty)&amount=\(getNum(diff: "easy"))"
                currentDiff.diff = "easy"
                
                
                print(urlString)
                
                performRequest(with: urlString, mainContent: true)
            }
            if difficulty == "medium"{
                let urlString = "\(quizURL)&category=\(category)&difficulty=\(difficulty)&amount=\(getNum(diff: "medium"))"
                currentDiff.diff = "medium"
                print(urlString)
                performRequest(with: urlString, mainContent: true)
            }
            if difficulty == "hard"{
                let urlString = "\(quizURL)&category=\(category)&difficulty=\(difficulty)&amount=\(getNum(diff: "hard"))"
                currentDiff.diff = "hard"
                print(urlString)
                performRequest(with: urlString, mainContent: true)
            }
            
        }
    }
    
    func performRequest(with urlString: String , mainContent: Bool){
        
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    fatalError("error in processing api")
                    
                }
                
                if let safeData = data{
                    
                    parseJSON(quizData: safeData, mainContent: mainContent)
                    
                }else{
                    fatalError("data failed")
                }
            }
            task.resume()
        }
    }
    func decode64 (data :String) -> String{
        let decodedObject = Data(base64Encoded: data)!
        let decodedObjectString = String(data: decodedObject, encoding: .utf8)!
        return decodedObjectString
    }
    
    
    func parseJSON(quizData : Data , mainContent: Bool) {
        let decoder = JSONDecoder()
        var num = 0
        print(currentDiff.diff)
        do{
            if mainContent == true{
                let decodedData = try decoder.decode(QuizData.self, from: quizData)
                print(getNum(diff: currentDiff.diff))
                while num < getNum(diff: currentDiff.diff){
                    let qn = decode64(data: decodedData.results[num].question)
                    
                    let category = decode64(data: decodedData.results[num].category)
                    let type = decode64(data:decodedData.results[num].type )
                    let ans = decode64(data:decodedData.results[num].correct_answer )
                    let difficulty = decode64(data:decodedData.results[num].difficulty )
                    
                    
                    if type == "multiple"{
                        let a = decode64(data:decodedData.results[num].incorrect_answers[0] )
                        let b = decode64(data:decodedData.results[num].incorrect_answers[1] )
                        let c = decode64(data:decodedData.results[num].incorrect_answers[2] )
                        let question = Question(q: qn, a: a, b: b, c: c, ans: ans, category: category, type: type, difficulty: difficulty)
                        quizBrain.questionBank.append(question)
                        num += 1
                    }else{
                        let a = "False"
                        let b = "0"
                        let c = "0"
                        let question = Question(q: qn, a: a, b: b, c: c, ans: ans, category: category, type: type, difficulty: difficulty)
                        quizBrain.questionBank.append(question)
                        num += 1
                        
                    }
                    
                    
                    
                }
                quizBrain.numOfCurrentQn = num
                print("Number of questions \(num)")
            }else{
                let decodedData = try decoder.decode(CatData.self, from: quizData)
                
                let easyNumber = decodedData.category_question_count.total_easy_question_count - 1
                let mediumNumber = decodedData.category_question_count.total_medium_question_count - 1
                let hardNumber = decodedData.category_question_count.total_hard_question_count - 1
                amount.easyQn = easyNumber
                amount.mediumQn = mediumNumber
                amount.hardQn = hardNumber
                print("easy \(amount.easyQn)")
                print("medium \(amount.mediumQn)")
                print("hard \(amount.hardQn)")
            }
            
        }catch{
            fatalError("error proccessing json \(error)")
        }
        
    }
    
    
    
}


