//
//  TabHomeView.swift
//  EasyBudget
//
//  Created by Andres Made on 8/5/23.
//

import SwiftUI

struct TabHomeView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TabHomeView()
}
