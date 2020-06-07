//
//  ContentView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        Group {
            
            if self.settings.isLogged {
                HomeView()
                Spacer()
            }
            else {
                EntryView()

            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
