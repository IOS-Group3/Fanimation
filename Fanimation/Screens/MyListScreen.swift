//
//  MyListScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//

import SwiftUI
import Firebase
struct MyListScreen: View {
	var body: some View {
		VStack {
			Text("My List")
			Button("Logout") {
				let firebaseAuth = Auth.auth()
				do {
					try! firebaseAuth.signOut()
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
}

func onLogOut() {
	if let window = UIApplication.shared.windows.first {
		window.rootViewController = UIHostingController(rootView: WelcomeScreen())
		window.makeKeyAndVisible()
	}
}

struct MyListScreen_Previews: PreviewProvider {
	static var previews: some View {
		MyListScreen()
	}
}
