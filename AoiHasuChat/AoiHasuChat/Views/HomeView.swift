//
//  HomeView.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var question: String = ""
    @State private var isTyping = false
    
    struct RequestItem: Encodable {
        let inputs: String

    }
    
    struct ResponseItem: Decodable {
        let output: String
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Logo()
                .frame(maxWidth: .infinity, alignment: .center)
            
            TypingText(fullText: viewModel.answer, isTyping: $isTyping)
            Spacer()
            
            VStack {
                InputText(text: $question, disabled: isTyping, onTap: viewModel.reset)
                SubmitButton(disabled: isTyping, action: sendRequest)
            }
        }.padding()
    }
    
    func sendRequest() {
        Task {
            try await viewModel.sendRequest(question: question)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
