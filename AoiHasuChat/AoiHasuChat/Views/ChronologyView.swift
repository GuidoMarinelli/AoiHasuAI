//
//  ChronologyView.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 05/08/23.
//

import SwiftUI

struct ChronologyView: View {
    
    let title: String
    
    var body: some View {
        
        Text("Chronology")
            .foregroundColor(Constants.customBlack)
            .navigationTitle(title)
        
        Text("pagina in alestimento")
    }
}

struct ChronologyView_Previews: PreviewProvider {
    static var previews: some View {
        ChronologyView(title: "Chronology")
    }
}
