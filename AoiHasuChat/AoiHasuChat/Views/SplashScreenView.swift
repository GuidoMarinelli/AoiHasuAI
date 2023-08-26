//
//  SplashScreenView.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        HStack {
            Text("AoiHasuAI")
                .font(.title)
            Image("BlueLotus")
                .resizable()
                .frame(width: 50, height: 30)
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
