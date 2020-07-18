//
//  LoginView.swift
//  Market List
//
//  Created by Arsalan Iravani on 17.07.2020.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = "airavani2018@ada.edu.az"
    @State var password = "123456"
    @State var message = ""
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                ZStack {
                    Image("drops")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                        Text("Welcome Back,")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text("Log In!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding()
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                Spacer().layoutPriority(-1)
                
                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                        .font(.body)
                }
                
                //                .luminanceToAlpha()
                Spacer().layoutPriority(-1)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 1.5)
                    )
                    .padding(40)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 1.5)
                    )
                    .padding(.horizontal, 40)
                
                Spacer()
                
                Button(action: {
                    
                    FirebaseManager.shared.signIn(email: email, password: password) { result in
                        switch result {
                        case .success(let result):
                            userState.isLoggedIn = true
                            message.removeAll()
                            print(result)
                        case .failure(let error):
                            message = error.localizedDescription
                        }
                    }
                }, label: {
                    Text("Log in")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(width: 250, height: 50)
                })
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .shadow(radius: 10, x: 10, y: 10)
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                NavigationLink(
                    destination: SignInView(), label: {
                        Text("Sign in")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: 250, height: 50)
                    }
                )
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .shadow(radius: 10, x: 10, y: 10)
                .foregroundColor(.white)
                .padding()
                
                
            }
            .animation(.default)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
