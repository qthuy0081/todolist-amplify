//
//  VerifyEmailView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI
import AWSMobileClient

struct VerifyEmailView: View {
    var body: some View {
          NavigationView {
                     ZStack{
                        LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                        form().padding(.bottom,400)
                        
            }
        }
    }
}

struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}

struct form: View {
    @State var code = ""
    @State var showingAlert = false
    @State var alertMess = ""
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
          VStack{
                  
                  VStack{
                      
                      HStack(spacing: 15){
                          
                          Image(systemName: "lock")
                              .foregroundColor(.black)
                          TextField("Enter Code", text: self.$code)
                          
                      }.padding(.vertical, 20)
                      
                     
                      
                  }
                  .padding(.vertical)
                  .padding(.horizontal, 20)
                  .padding(.bottom, 40)
                  .background(Color.white)
                  .cornerRadius(10)
                  .padding(.top, 25)
                  
                  
                  Button(action: {
                    self.verifyCode()
                  }) {
                      
                      Text("Verify")
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
            Button(action: {
                self.resendCode()
                           }) {
                               
                               Text("Resend code")
                                   .foregroundColor(.white)
                           
                           }
                           .padding(.top, 20)
        }.padding()
    
    }
    
    func handleConfirmation(signUpResult: SignUpResult?, error: Error?) {
        if let error = error {
            print("\(error)")
            self.showingAlert = true
            self.alertMess = "Invalid verification code provided, please try again."

            return
        }
        
        guard let signUpResult = signUpResult else {
            return
        }
        
        switch(signUpResult.signUpConfirmationState) {
        case .confirmed:
            print("User is signed up and confirmed.")
            
            DispatchQueue.main.async {
                self.settings.isLogged = true
            }
            
        case .unconfirmed:
            print("User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
        case .unknown:
            print("Unexpected case")
        }
    }
    func verifyCode() {
        if(self.settings.username == "" || self.code == "") {
            print("No username")
            return
        }
        
        AWSMobileClient.default().confirmSignUp(username: self.settings.username,
                                                       confirmationCode: code,
                                                       completionHandler: handleConfirmation)
    }
    func resendCode() {
        if(self.settings.username == "" || self.code == "") {
            return
        }
        AWSMobileClient.default().confirmSignUp(username: self.settings.username,
        confirmationCode: code,
        completionHandler: handleConfirmation)
    }
}
