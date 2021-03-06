//
//  LoginView.swift
//  TodoList-Amplify
//
//  Created by Dinh Quoc Thuy on 6/7/20.
//  Copyright © 2020 Dinh Quoc Thuy. All rights reserved.
//

import SwiftUI
import AWSMobileClient
import Amplify
import SafariServices
struct EntryView: View {
    var body: some View {
        NavigationView {
            ZStack{
                       
                       LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                       
                       if UIScreen.main.bounds.height > 900{
                           
                        Home()
                       }
                       else{
                           
                           ScrollView(.vertical, showsIndicators: false) {
                               
                               Home()
                         
                           }
                       }
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
struct Home : View {
    
    @State var index = 0
    @State var showWebView = false
    var body : some View{
        
        VStack{
            
            Image("logo")
            .resizable()
                .frame(width: 320, height: 200).padding(.top, -120)
            
            HStack{
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                       self.index = 0
                    }
                    
                }) {
                    
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    
                   withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                       
                      self.index = 1
                   }
                    
                }) {
                    
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            if self.index == 0{
                
                LoginView()
            }
            else{
                
                SignUpView()
            }
            
            if self.index == 0{
                
                NavigationLink(destination: ResetPasswordView(), label: {
                    Text("Forget Password?")
                    .foregroundColor(.white)
                }).padding(.top,20)
               
            }
            
            HStack(spacing: 15){
                
                Color.white.opacity(0.7)
                .frame(width: 35, height: 1)
                
                Text("Or")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Color.white.opacity(0.7)
                .frame(width: 35, height: 1)
                
            }
            .padding(.top, 10)
            
            HStack{
            
                Button(action: {
                   // self.signInWithFB()
                    self.showWebView = true
                }) {
                    
                    Image("fb")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                    .clipShape(Circle()).sheet(isPresented:$showWebView , content: {
                        SafariView(url:URL(string: "https://todolistamplify2be342c0-2be342c0-dev.auth.ap-southeast-1.amazoncognito.com/login?response_type=code&client_id=5q44dtmqp13398c5cerneigo50&redirect_uri=todolist://")!)
                    })
                
                Button(action: {
                    
                }) {
                    
                    Image("google")
                        .renderingMode(.original)
                        .padding()
                    
                }.background(Color.white)
                .clipShape(Circle())
                .padding(.leading, 25)
            }
            .padding(.top, 10)
            
        }
        .padding()
    }
    func signInWithFB() {
        
        AWSMobileClient.default().federatedSignIn(providerName: IdentityProvider.facebook.rawValue, token: "", completionHandler: {
            (userState, error) in
            if let error = error as? AWSMobileClientError {
                print(error.localizedDescription)
            }
            if let userState = userState {
                print("Status: \(userState.rawValue)")
            }
        })
       
    }
}
struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
