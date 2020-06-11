//
//  LoginView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI
import AWSMobileClient
struct LoginView: View {
    @State var username = ""
    @State var pass = ""
    @State var visible = false
    @State var showingAlert = false
    @State var alertMess = ""
    @EnvironmentObject var settings: UserSettings
    
    var body : some View{
    
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    TextField("Enter Username", text: self.$username)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    if self.visible {
                        TextField("Password",text: self.$pass).autocapitalization(.none)
                    }
                    else {
                        SecureField("Password", text: self.$pass).autocapitalization(.none)
                                           
                    }
                   
                    Button(action: {
                        self.visible.toggle()
                    }) {
                        
                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.black)
                    }
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                self.login()
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(
            
                LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
                .shadow(radius: 15).alert(isPresented: self.$showingAlert, content: {
                    Alert(title: Text("Error"), message: Text(self.alertMess), dismissButton: .default(Text("Try again")))
                })
        }
        
    }
    
    func login() {
        AWSMobileClient.default().signIn(username: self.username, password: self.pass) {
                          (signInResult, error) in
                              if let error = error  {
                                  print("There's an error : \(error.localizedDescription)")
                                  print(error)
                                 self.showingAlert = true
                                self.alertMess = "Incorrect username or password"
                                  return
                              }
                          
                              guard let signInResult = signInResult else {
                                  return
                              }
                          
                              switch (signInResult.signInState) {
                              case .signedIn:
                                  print("User is signed in.")
                                  
                                  self.settings.isLogged = true
                                  
                              case .newPasswordRequired:
                                DispatchQueue.main.async {
                                    self.settings.isLogged = true
                                }

                                  print("User needs a new password.")
                              default:
                               //self.showingAlert = true
                                  print("Sign In needs info which is not et supported.")
                              }
                      }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
