//
//  Authorization.swift
//  Market List
//
//  Created by Arsalan Iravani on 18.07.2020.
//

import SwiftUI
import FirebaseAuth

struct Authorization: View {
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        Group {
            if userState.isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }.onAppear {
            userState.isLoggedIn = Auth.auth().currentUser != nil
        }
    }
}

struct Authorization_Previews: PreviewProvider {
    static var previews: some View {
        Authorization()
    }
}
