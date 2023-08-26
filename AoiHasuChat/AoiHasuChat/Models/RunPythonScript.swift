//
//  RunPythonScript.swift
//  LamaTest
//
//  Created by Guido Marinelli on 22/08/23.
//

import Foundation
import PythonKit

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Published private(set) var answer: String = ""
        
        func sendRequest(question: String, retrievedMessages: PythonObject) -> PythonObject {
            let sys: PythonObject = Python.import("sys")
            
            sys.path.append("/Users/guidomarinelli/Developer/AoiHasuAI/AoiHasuChat/AoiHasuChat/Models/")
            let file: PythonObject = Python.import("TextGeneration")
            
            let result = file.get_completion(question, retrievedMessages)
            self.answer = String(result[0])!
            let retrievedMessages = result[1]
            
            return retrievedMessages
        }
        
        func reset() {
            answer = ""
        }
    }
}
