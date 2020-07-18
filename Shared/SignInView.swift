//
//  SignInView.swift
//  Market List
//
//  Created by Arsalan Iravani on 18.07.2020.
//

import SwiftUI

struct SignUpView: View {
    
    @State var name = ""
    @State var dateOfBirth = Date()
    @State var email = ""
    @State var password = ""
    
    @State var message = ""
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        
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
                    .textContentType(.password)
                
                Spacer()
                
                Button(action: {
                    FirebaseManager.shared.createUser(withEmail: email, password: password) { result in
                        switch result {
                        case .success(_):
                            userState.isLoggedIn = true
                            message.removeAll()
                        case .failure(let error):
                            message = error.localizedDescription
                        }
                    }
                }, label: {
                    Text("Sign In")
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
                
            }
        }
        .animation(.default)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
