//
//  AoiHasuChatApp.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

@main
struct AoiHasuChatApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .commands {
            SidebarCommands()
        }
    }
}
