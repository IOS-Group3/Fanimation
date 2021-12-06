//
//  ProfileScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct ProfileScreen: View {

    
    var body: some View {
		Text("Profile screen")
		Button("Logout") {
			let firebaseAuth = Auth.auth()
			do {
				try firebaseAuth.signOut()
				onLogOut()
			} catch let signOutError as NSError {
				print("Error signing out: %@", signOutError)
			}
			
		}.padding()
			.frame(width: 300, height: 50)
			.background(Color("blue1"))
			.cornerRadius(20)
			.foregroundColor(Color("light"))
	}
}

struct ProfileScreen_Previews: PreviewProvider {
	static var previews: some View {
		ProfileScreen()
	}
}

//Here's a link for reference:https://firebase.google.com/docs/storage/ios/upload-files
func uploadProfile(imageData:URL) {
    let user = Auth.auth().currentUser
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()

    // Create a storage reference from our storage service
    let storageRef = storage.reference().child("Users/\(user?.uid)")
    
    storageRef.putFile(from: imageData, metadata: nil) { storageData, error in
        if (error != nil) {
            print(error?.localizedDescription)
        }
        else {
            storageRef.downloadURL { url, error in
                if error != nil {
                    return
                }
                let urlString = url?.absoluteString
            }
        }
    }
    
}
func onLogOut() {
	if let window = UIApplication.shared.windows.first {
		window.rootViewController = UIHostingController(rootView: WelcomeScreen())
		window.makeKeyAndVisible()
	}
}

func updateUserProfile(photoURL:URL) {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.photoURL = photoURL
    changeRequest?.commitChanges { error in
        if error != nil {
            print("\(error?.localizedDescription)")
        }
        else {
            print("Update successful!")
        }
    }
}
