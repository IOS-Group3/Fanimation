//
//  SignupScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct SignupScreen: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@State private var email:String = ""
	@State private var password:String = ""
	@State var showPassword:Bool = false
	@State var errormessage:String = ""
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor(named: "blue1") ?? UIColor.blue, .font: UIFont.systemFont(ofSize: 34, weight: .bold)]
	}
	
	var body: some View {
		ZStack {
			Color("light")
				.ignoresSafeArea()
			VStack {
				
				HStack {
					Image(systemName: "envelope.fill")
					TextField("Email", text: $email)
				}
				.padding(.vertical, 10)
				.overlay(Rectangle().frame(height: 2).padding(.top, 35))
				.foregroundColor(Color("dark"))
				.padding(10)
				
				HStack {
					Image(systemName: "lock.fill")
					if showPassword {
						TextField("Password", text: $password)
						Image(systemName: "eye.fill").onTapGesture {
							showPassword.toggle()
						}
						
					} else {
						SecureField("Password", text: $password)
						Image(systemName: "eye.slash.fill").onTapGesture {
							showPassword.toggle()
						}
					}
				}
				.padding(.vertical, 10)
				.overlay(Rectangle().frame(height: 2).padding(.top, 35))
				.foregroundColor(Color("dark"))
				.padding(10)
				
				Spacer()
				Button(action: {
					Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines)) { authResult, error in
						//Signup successful
						if (error == nil) {
							let uid = Auth.auth().currentUser?.uid
							createAccount(email: email, uid: uid!)
							goMain()
						}
						else {//Failure
							errormessage = error!.localizedDescription
						}
					}
				}) {
					
					Text("Signup")
						.padding()
						.frame(width: 300, height: 50)
						.background(Color("blue1"))
						.cornerRadius(20)
						.foregroundColor(Color("light"))
					
				}
				//Error message
				Text(errormessage).foregroundColor(.red)
				
				Spacer()
				HStack{
					Text("Have an account?").foregroundColor(Color("dark"))
					Button(
						"Sign in.",
						action: { self.presentationMode.wrappedValue.dismiss() }
					)
				}
				Spacer()
				Spacer()
				Spacer()
			}.padding()
				.navigationBarTitle(Text("Signup"), displayMode: .large)
		}
	}
}


func createAccount(email: String, uid: String) {
	let db = Firestore.firestore()
	var ref: DocumentReference? = nil
	
	//Add user
	ref = db.collection("Users").document(email)
	ref?.setData([
		"userID": uid
	])
}

struct SignupScreen_Previews: PreviewProvider {
	static var previews: some View {
		SignupScreen()
	}
}
