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
            
            ZStack {
                
                Image("drops")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .layoutPriority(-1)
                
                
                VStack {
                    
                    Spacer()
                    Spacer()
                    
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                            .font(.body)
                    }
                    
                    GradientTextField(placeholder: "Email", value: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                    
                    GradientTextField(placeholder: "Password", isSecured: true, value: $password)
                    
//                    Spacer()
                    
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
                            .frame(width: 300, height: 50)
                    })
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Capsule())
                    .shadow(radius: 10, x: 10, y: 10)
                    .foregroundColor(.white)
                    .padding()
                    
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SignUpView(), label: {
                            Text("Sign up")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(width: 300, height: 50)
                        }
                    )
                    .background(Color.secondary)
                    .clipShape(Capsule())
                    .shadow(radius: 10, x: 10, y: 10)
                    .foregroundColor(.white)
                    .padding()
                    
                    Spacer()
                    
                }
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
