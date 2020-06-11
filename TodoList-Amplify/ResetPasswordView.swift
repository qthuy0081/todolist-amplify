//
//  ResetPasswordView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI
import AWSMobileClient

struct ResetPasswordView: View {
    var body: some View {
         NavigationView {
                            ZStack{
                               LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                               forgetPassword().padding(.bottom,400)
                               
                   }
               }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
struct forgetPassword: View {
    
    @State var submit = false
    @State var username = ""
    @State var passwordChanged = false
    var body: some View {
          VStack{
            if self.passwordChanged {
                VStack{
                    Image("correct-mark").resizable().frame(width:60, height: 60)
                    Text("Password changed, try to login again").foregroundColor(.white).fontWeight(.bold).padding(.top,20)
                }
            }
            else {
                if self.submit {
                    inputNewPassword(username: self.$username, submit: self.$submit,passwordChanged: self.$passwordChanged)
                }
                else {
                    inputUserName(username: self.$username,submit: self.$submit)
                }
            }
          
        }.padding()
    
    }
}

struct inputUserName: View {
    @Binding var username:String
    @Binding var submit: Bool
    @State var showingAlert = false
    var body: some View {
        VStack {
            
        
        VStack{
                         
                         HStack(spacing: 15){
                             
                             Image(systemName: "person")
                                 .foregroundColor(.black)
                             TextField("Enter Username", text: self.$username)
                             
                         }.padding(.vertical, 20)
                         
                        
                         
                     }
                     .padding(.vertical)
                     .padding(.horizontal, 20)
                     .padding(.bottom, 40)
                     .background(Color.white)
                     .cornerRadius(10)
                     .padding(.top, 25)
            Button(action: {
                //submit function
                                
                self.submitUserName()
                            
                                
                                
                            }) {
                                
                                Text("Submit")
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
                                Alert(title: Text("Error"), message: Text("User doesn't exist"), dismissButton: .default(Text("Try again")))
                            })
        }
    }
    func submitUserName() {
        AWSMobileClient.default().forgotPassword(username: self.username, completionHandler: {forgotPasswordResult, error in
            if let forgotPassResult = forgotPasswordResult {
                switch forgotPassResult.forgotPasswordState {
                case .confirmationCodeSent:
                    guard let codeDeliveryDetails = forgotPassResult.codeDeliveryDetails else {
                                        return
                                       }
                    self.submit = true
                    print("Confirmation code sent via \(codeDeliveryDetails.deliveryMedium) to: \(codeDeliveryDetails.destination!)")
                default:
                    self.showingAlert = true
                    print("Error: Invalid case.")
                }
            } else if let error = error {
                self.showingAlert = true
                print(error.localizedDescription)
            }
            
        })
    }
}

struct inputNewPassword: View {
    @Binding var username:String
    @Binding var submit: Bool
    @State var code = ""
    @State var newPassword = ""
    @State var visible = false
    @State var showingAlert = false
    @Binding var passwordChanged: Bool
    @EnvironmentObject var settings: UserSettings
       var body: some View {
           VStack {
               
           
           VStack{
                            
                            HStack(spacing: 15){
                                
                                Image(systemName: "lock")
                                    .foregroundColor(.black)
                                TextField("Enter Code", text: self.$code)
                                
                            }.padding(.vertical, 20)
                        HStack(spacing: 15){
                                    
                                    Image(systemName: "lock")
                                    .resizable()
                                    .frame(width: 15, height: 18)
                                    .foregroundColor(.black)
                                    
                                    if self.visible {
                                        TextField("Password",text: self.$newPassword).autocapitalization(.none)
                                    }
                                    else {
                                        SecureField("Password", text: self.$newPassword).autocapitalization(.none)
                                                           
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
                                 //Change password function
                            self.changePassword()
                               }) {
                                   
                                   Text("Change password")
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
                                Alert(title: Text("Error"), message: Text("invalid code"), dismissButton: .default(Text("Try again")))
                            })
            Button(action: {
                self.submit = false
                                     }) {
                                         
                                         Text("Other user?")
                                             .foregroundColor(.white)
                                     
                                     }
                                     .padding(.top, 20)
           }
       }
    func changePassword() {
        if (self.username == "" || self.code == "" || self.newPassword == ""){
            return
        }
        AWSMobileClient.default().confirmForgotPassword(username: self.username,
                                                               newPassword: self.newPassword,
                                                                     confirmationCode: self.code) { (forgotPasswordResult, error) in
                  if let forgotPasswordResult = forgotPasswordResult {
                      switch(forgotPasswordResult.forgotPasswordState) {
                      case .done:
                        print("Password changed")
                        DispatchQueue.main.async {
                            self.passwordChanged = true
                        }
                      default:
                        self.showingAlert = true
                          print("Error: Could not change password.")
                      }
                  } else if let error = error {
                    self.showingAlert = true
                      print("Error occurred: \(error.localizedDescription)")
                  }
              }
    }
}
