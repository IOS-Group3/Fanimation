//
//  LoginScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginScreen: View {
	@State private var email:String = ""
	@State private var password:String = ""
	@State var showPassword:Bool = false
	@State var errorMessage:String = ""
	
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
				
				HStack {
					Spacer()
					NavigationLink(destination: ForgotPasswordScreen()) {
						Text("Forgot Password?")
					}.padding(.trailing)
				}
				Spacer()
				Button(action: {
					//Signs in user
					Auth.auth().signIn(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines)) {  authResult, error in
						if (error == nil) {
							//Sends user to the main screen
							goMain()
						} else { //Error logging in
							errorMessage = error!.localizedDescription
						}
						
					}
				}) {
					
					Text("Login")
						.padding()
						.frame(width: 300, height: 50)
						.background(Color("blue1"))
						.cornerRadius(20)
						.foregroundColor(Color("light"))
				}
				//Error message displayed
				Text(errorMessage).foregroundColor(.red)
				
				Spacer()
				HStack{
					Text("Don't have an account?").foregroundColor(Color("dark"))
					NavigationLink(destination: SignupScreen()) {
						Text("Signup now")
					}
				}
				Spacer()
				Spacer()
			}.padding()
				.navigationBarTitle(Text("Login"), displayMode: .large)
		}
	}
}
func goMain() {
	if let window = UIApplication.shared.windows.first {
		window.rootViewController = UIHostingController(rootView: MainScreen())
		window.makeKeyAndVisible()
	}
}
struct LoginScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginScreen()
	}
}
