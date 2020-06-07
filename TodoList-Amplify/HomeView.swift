//
//  HomeView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject  var settings: UserSettings
    var body: some View {
        VStack {
            Text("Home")
            Button(action: {
                self.settings.isLogged = false
            }, label: {
                Text("Logout")
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
