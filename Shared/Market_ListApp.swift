//
//  Market_ListApp.swift
//  Shared
//
//  Created by Arsalan Iravani on 12.07.2020.
//

import SwiftUI
import Firebase

@main
struct Market_ListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            LoginView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Login")
                }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
    
}
