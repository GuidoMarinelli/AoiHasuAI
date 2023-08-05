//
//  InputText.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

func InputText(text: Binding<String>, disabled: Bool, onTap: @escaping () -> Void) -> some View {
    TextField("Type your message...", text: text)
        .padding()
        .textFieldStyle(.roundedBorder)
        .font(.custom("HelveticaNeue", size: 12))
        .cornerRadius(40)
        .onTapGesture {
            text.wrappedValue = ""
            onTap()
        }
}
