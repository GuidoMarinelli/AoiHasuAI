//
//  Logo.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 05/08/23.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        HStack {
            Text("AoiHasuChat")
                .font(.title)
            Image("BlueLotus")
                .resizable()
                .frame(width: 50, height: 30)
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
