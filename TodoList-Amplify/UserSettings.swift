//
//  UserSettings.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import UIKit

class UserSettings: ObservableObject {
    @Published var isLogged = true
    @Published var username = ""
    @Published var email = ""
}
