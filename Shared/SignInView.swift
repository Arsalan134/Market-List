//
//  SignInView.swift
//  Market List
//
//  Created by Arsalan Iravani on 18.07.2020.
//

import SwiftUI

struct SignInView: View {
    
    @State var email = ""
    @State var password = ""
    @State var message = ""
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        
        VStack {
            
            ZStack {
                Image("drops")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Sign In!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
            
            
        }
        .animation(.default)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
