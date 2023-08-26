//
//  HomeView.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI
import PythonKit

struct HomeView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var question: String = ""
    @State private var isTyping = false
    @State private var memory: PythonObject = []
    
    let title: String
    
    var body: some View {
       
        Text("Home")
            .foregroundColor(Constants.customBlack)
            .navigationTitle(title)
        
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
            let previousMemory = memory
            memory = viewModel.sendRequest(question: question, retrievedMessages: previousMemory)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(title: "Home")
    }
}
