//
//  LoginScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI

struct LoginScreen: View {
	@State private var userName:String = ""
	@State private var password:String = ""
	@State var showPassword:Bool = false
	
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
					TextField("Email", text: $userName)
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
					//TODO: add functionality to the login button
				}) {
					
					Text("Login")
						.padding()
						.frame(width: 300, height: 50)
						.background(Color("blue1"))
						.cornerRadius(20)
						.foregroundColor(Color("light"))
				}
				Spacer()
				HStack{
					Text("Don't have an account?").foregroundColor(Color("dark"))
					NavigationLink(destination: SignupScreen()) {
						Text("Signup now")
					}
				}
				Spacer()
				Spacer()
				Spacer()
			}.padding()
				.navigationBarTitle(Text("Login"), displayMode: .large)
		}
	}
}

struct LoginScreen_Previews: PreviewProvider {
	static var previews: some View {
		LoginScreen()
	}
}
