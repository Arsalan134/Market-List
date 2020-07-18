//
//  Market_ListApp.swift
//  Shared
//
//  Created by Arsalan Iravani on 12.07.2020.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct Market_ListApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let userState = UserState()
    
    var body: some Scene {
        WindowGroup {
            
            Authorization()
                .environmentObject(userState)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Login")
                }
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("sasdkdkdkslk")
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Salamlasm")
        
        FirebaseApp.configure()
        
        return true
    }
    
}
