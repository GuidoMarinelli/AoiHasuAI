//
//  HomeViewExtensionForNetwork.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import Foundation

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        @Published private(set) var answer: String = ""
        
        func sendRequest(question: String) async throws {
            guard !question.isEmpty else { return }
            let requestItem = RequestItem(inputs: question)
            guard let payload = try? JSONEncoder().encode(requestItem) else { return }
            
            let url = URL(string: "http://127.0.0.1:8000/generate")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = payload
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.answer = "Unable to receive answer."
                }
                return
            }
            
            let json = try JSONDecoder().decode(ResponseItem.self, from: data)
            self.answer = json.output
        }
        
        func reset() {
            answer = ""
        }
    }
}
