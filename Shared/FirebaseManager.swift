//
//  FirebaseManager.swift
//  Market List
//
//  Created by Arsalan Iravani on 14.07.2020.
//

import Foundation

import FirebaseAuth

class FirebaseManager  {
    
    static var shared = FirebaseManager()
    
    private init() {
        
    }
    
    func createUser(withEmail email: String, password: String, completed: @escaping (Result<AuthDataResult, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completed(.failure(error))
            } else {
                completed(.success(authResult!))
            }
        }
        
    }
    
    func signIn(email: String, password: String, completed: @escaping (Result<AuthDataResult, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completed(.failure(error))
            } else {
                completed(.success(authResult!))
            }
            
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    func getUserDetails(completion: @escaping (User) -> ()) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            completion(User())
        }
    }
    
    func getUserProfile() -> FirebaseAuth.User? {
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            let uid = user.uid
            let email = user.email
            let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
        }
        return user
    }
    
    
    func updateUserProfile(displayName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { (error) in
            
        }
    }
    
    func setUserEmail(_ email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { (error) in
            
        }
    }
    
    func setPassword(_ password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            
        }
    }
    
    func sendResetEmail() {
        guard let email = Auth.auth().currentUser?.email else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            
        }
    }
    
    
    func deleteUser() {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // Account deleted.
            }
        }
    }
    
    func sendUserVerificationEmail() {
        Auth.auth().useAppLanguage()
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            
        }
    }
    
    func reauthenticateUser() {
        let user = Auth.auth().currentUser
        var credential: AuthCredential!
        
        //FIXME: Prompt the user to re-provide their sign-in credentials
        
        user?.reauthenticate(with: credential) { result, error in
            if let error = error {
                // An error happened.
            } else {
                // User re-authenticated.
            }
        }
    }
    
    func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil ? true : false
    }
    
    
}

