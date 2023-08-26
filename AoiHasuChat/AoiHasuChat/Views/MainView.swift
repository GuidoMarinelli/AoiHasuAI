//
//  MainView.swift
//  AoiHasuChat
//
//  Created by Guido Marinelli on 04/08/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var showSplash = true
    
    var body: some View {
        VStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
                
                Text("Copyright © 2023 AoiHasuAI owned by Guido Marinelli. All rights reserved.").frame(alignment: .bottom)
                
            } else {
                NavigationView {
                    List {
                        NavigationLink {
                            HomeView(title: "Home")
                        } label: {
                            Label("Home", systemImage: "house")
                        }
                        
                        NavigationLink {
                            ChronologyView(title: "Chronology")
                        } label: {
                            Label("Chronology", systemImage: "clock")
                        }
                    }
                    .listStyle(SidebarListStyle())
                    .frame(minWidth: 100, idealWidth: 100)
                    //.background(Constants.customBlack)
                    .navigationTitle("Sidebar")
                    
                    HomeView(title: "Home")
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar, label: {
                            Image(systemName: "sidebar.leading")
                        })
                    }
                }
            }
        }
        .padding()
        .frame(
            minWidth: 642,
            idealWidth: 1000,
            maxWidth: .infinity,
            minHeight: 428,
            idealHeight: 800,
            maxHeight: .infinity)
        .background(Constants.customBlack).ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
