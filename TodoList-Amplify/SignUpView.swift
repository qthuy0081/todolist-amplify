//
//  SignUpView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var username = ""
    @State var mail = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var visible2 = false
    @State var alert = true
    @State var error = ""
    @State var goToVerify = false
    var body : some View{
            VStack{
                       
                       VStack{
                           HStack(spacing: 15){
                                              
                                              Image(systemName: "person")
                                                  .foregroundColor(.black)
                                              TextField("Enter Username", text: self.$username)
                                              
                                          }.padding(.vertical, 20)
                           HStack(spacing: 15){
                               
                               Image(systemName: "envelope")
                                   .foregroundColor(.black)
                               
                               TextField("Enter Email Address", text: self.$mail)
                               
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
                           
                           Divider()
                           
                           HStack(spacing: 15){
                               
                               Image(systemName: "lock")
                               .resizable()
                               .frame(width: 15, height: 18)
                               .foregroundColor(.black)
                               
                               if self.visible2 {
                                    TextField("Re-Enter Password",text: self.$repass).autocapitalization(.none)
                                }
                                else {
                                    SecureField("Re-Enter Password", text: self.$repass).autocapitalization(.none)
                                                       
                                }
                               
                                Button(action: {
                                    self.visible2.toggle()
                                }) {
                                    
                                    Image(systemName: self.visible2 ? "eye.slash.fill" : "eye.fill")
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
                       
                NavigationLink(destination: VerifyEmailView(), isActive: self.$goToVerify, label: {
                    EmptyView()
                })
                       Button(action: {
                        self.goToVerify = true
                       }) {
                           
                           Text("SIGNUP")
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
                       .shadow(radius: 15)
                         
                   }
        
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
