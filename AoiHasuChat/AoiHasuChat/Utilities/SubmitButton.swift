//
//  SubmitButton.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

func SubmitButton(disabled: Bool, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Text("Send Message")
            .font(.custom("HelveticaNeue", size: 10))
    }
    .padding()
    .disabled(disabled)
    .keyboardShortcut(.defaultAction)
}
