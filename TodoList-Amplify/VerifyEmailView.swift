//
//  VerifyEmailView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI

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
                  .shadow(radius: 15)
            Button(action: {
                               
                           }) {
                               
                               Text("Resend code")
                                   .foregroundColor(.white)
                           
                           }
                           .padding(.top, 20)
        }.padding()
    
    }
}
