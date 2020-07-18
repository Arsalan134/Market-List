//
//  Authorization.swift
//  Market List
//
//  Created by Arsalan Iravani on 18.07.2020.
//

import SwiftUI

struct Authorization: View {
    
    @EnvironmentObject var userState: UserState
    
    var body: some View {
        
        if userState.isLoggedIn {
            ContentView()
        } else {
            LoginView()
        }
        
    }
}

struct Authorization_Previews: PreviewProvider {
    static var previews: some View {
        Authorization()
    }
}
