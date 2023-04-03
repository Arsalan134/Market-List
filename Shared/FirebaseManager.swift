//
//  FirebaseManager.swift
//  Market List
//
//  Created by Arsalan Iravani on 14.07.2020.
//

import Foundation
import UIKit

import FirebaseAuth
import FirebaseStorage


class FirebaseManager  {
    
    static var shared = FirebaseManager()
    
    private init() {
        
    }
    
    func createUser(withName name: String, surname: String, email: String, password: String, image: UIImage?, completed: @escaping (Result<AuthDataResult, Error>) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completed(.failure(error))
            } else {
                self?.uploadImage(image) { result in
                    switch result {
                    case .success(let url):
                        self?.updateUserProfile(displayName: name, photoURL: url)
                        completed(.success(authResult!))
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        
       
        
    }
    
    func uploadImage(_ image: UIImage?, completed: @escaping (Result<URL, Error>) -> Void) {
        
        guard let id = Auth.auth().currentUser?.uid else {
            print("ERROR 91j9js")
             return
        }
        
        let imagesRef = Storage.storage().reference().child("userProfileImages").child(id)
        
        // Data in memory
        guard let data = image?.pngData() else {
            print("ERROR 13i9i")
            return
        }
        
        // Create a reference to the file you want to upload
        
        // Upload the file to the path "images/"
        let uploadTask = imagesRef.putData(data, metadata: nil) { (metadata, error) in
            
            if let error = error {
                completed(.failure(error))
                return
            }
            
//            guard let metadata = metadata else {
//                return
//            }
            
            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
            
            // You can also access to download URL after upload.
            imagesRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                
                completed(.success(downloadURL))
            }
        }
        
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
            print(snapshot)
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
            print(snapshot)
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentComplete)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            print(snapshot)
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completed(.failure(error))
//                switch (StorageErrorCode(rawValue: error.code)!) {
//                case .objectNotFound:
//                    // File doesn't exist
//                    break
//                case .unauthorized:
//                    // User doesn't have permission to access file
//                    break
//                case .cancelled:
//                    // User canceled the upload
//                    break
//                case .unknown:
//                    // Unknown error occurred, inspect the server response
//                    break
//                default:
//                    // A separate error occurred. This is a good place to retry the upload.
//                    break
//                }
            }
        }
    }
    
    func downloadImage(path: String?, completed: @escaping (Result<UIImage, Error>) -> Void) {
        guard let path = path else {
            return
        }
        
        let imageRef = Storage.storage().reference().child(path)
        imageRef.getData(maxSize: 1024 * 1024) { data, error in
            if let error = error {
                completed(.failure(error))
            } else {
                if let image = UIImage(data: data!) {
                    completed(.success(image))
                }
            }
        }
    }
    
    func updateUserProfile(displayName: String, photoURL: URL?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        
        if let url = photoURL {
            changeRequest?.photoURL = url
        }
        
        changeRequest?.commitChanges { (error) in
            
        }
    }
    
    func signIn(email: String, password: String, completed: @escaping (Result<AuthDataResult, Error>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completed(.failure(error!))
            } else {
                completed(.success(authResult!))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print ("Error signing out: ", error)
        }
        
    }
    
    func getUserDetails(completion: @escaping (User) -> ()) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            //FIXME: add user
            completion(User())
        }
    }
    
    func getUserProfile() -> FirebaseAuth.User? {
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
//            let uid = user.uid
//            let email = user.email
//            let photoURL = user.photoURL
            var multiFactorString = "MultiFactor: "
            for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
            }
        }
        return user
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
            if error != nil {
                // An error happened.
            } else {
                // User re-authenticated.
            }
        }
    }
    
    func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    
}

