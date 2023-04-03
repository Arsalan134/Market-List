//
//  SignInView.swift
//  Market List
//
//  Created by Arsalan Iravani on 18.07.2020.
//

import SwiftUI

struct SignUpView: View {
    
    @State var name = ""
    @State var surname = ""
    @State var dateOfBirth = Date()
    @State var email = ""
    @State var password = ""
    @State var gender = 0
    
    @State var message = ""
    
    @State private var showingImagePicker = false
    @State private var image = Image(systemName: "person.crop.circle.fill")
    @State private var inputImage: UIImage?
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        
        ZStack {
            
            Image("drops")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .layoutPriority(-1)
            
            VStack {
                
                Spacer()
                
                if !message.isEmpty {
                    Text(message)
                        .foregroundColor(.red)
                        .padding()
                        .font(.body)
                }
                
                Spacer()
                
                Group {
                    
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 80, maxHeight: 80)
                        .clipShape(Circle())
                        .onTapGesture {
                            showingImagePicker = true
                        }
                    
                    Spacer()
                    
                    GradientTextField(placeholder: "Name", value: $name)
                        .textContentType(.name)
                    
                    GradientTextField(placeholder: "Surname", value: $surname)
                        .textContentType(.familyName)
                    
                    GradientTextField(placeholder: "Email", value: $email)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                    
                    GradientTextField(placeholder: "Password", isSecured: true, value: $password)
                        .textContentType(.password)
                }
                
                Spacer()
                
                Button(action: {
                    FirebaseManager.shared.createUser(withName: name, surname: surname, email: email, password: password, image: inputImage) { result in
                        switch result {
                        case .success(_):
                            userState.isLoggedIn = true
                            message.removeAll()
                        case .failure(let error):
                            message = error.localizedDescription
                        }
                    }
                }, label: {
                    Text("Sign up")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(width: 300, height: 50)
                })
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .shadow(radius: 10, x: 10, y: 10)
                .foregroundColor(.white)
                .padding()
                
//                SignInWithAppleButton(
//                    onRequest: { request in
//                        print(request)
//                    },
//                    onCompletion: { result in
//                        switch result {
//                        case .success(let authorization):
//                            print(authorization)
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
//                )
//                .frame(minWidth: 140, maxWidth: 300, minHeight: 30, idealHeight: 44, maxHeight: 50, alignment: .center)
//                .clipShape(Capsule())
//                .padding()
                
                Spacer()
                
            }
        }
        .animation(.default)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
