//
//  GradientTextField.swift
//  Market List
//
//  Created by Arsalan Iravani on 19.07.2020.
//

import SwiftUI

struct GradientTextField: View {
    
    @State var placeholder = ""
    @State var isSecured = false
    
    @Binding var value: String
    
    var body: some View {
        if isSecured {
            SecureField(placeholder, text: $value)
                .textContentType(.password)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 1.5)
                )
                .padding()
            
        } else {
            TextField(placeholder, text: $value)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 1.5)
                )
                .padding()
        }
    }
}

struct GradientTextField_Previews: PreviewProvider {
    @State private static var test = ""
    static var previews: some View {
        GradientTextField(placeholder: "salam", value: $test)
    }
}
