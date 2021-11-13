//
//  MainScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordScreen: View {
	@State private var email:String = ""
	@State private var errorMessage:String = ""
	@State private var successMessage:String? = ""
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor(named: "blue1") ?? UIColor.blue, .font: UIFont.systemFont(ofSize: 34, weight: .bold)]
	}
	var body: some View {
		ZStack{
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
				
				
				.padding(.vertical, 10)
				.overlay(Rectangle().frame(height: 2).padding(.top, 35))
				.foregroundColor(Color("dark"))
				.padding(10)
				
				Text(errorMessage).foregroundColor(.red)
				Text(successMessage ?? "").foregroundColor(.green)
				Button(action: {
					errorMessage = ""
					successMessage = ""
					Auth.auth().sendPasswordReset(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines)){ error in
						if (error == nil) {
							errorMessage = ""
							successMessage = "Reset Email Sent."
						} else { //Error logging in
							errorMessage = error!.localizedDescription
							successMessage = ""
						}
						
					}
				}) {
					Text("Send Reset Email")
						.padding()
						.frame(width: 300, height: 50)
						.background(Color("blue1"))
						.cornerRadius(20)
						.foregroundColor(Color("light"))
				}
				Spacer()
			}.padding()
		}
		
	}
}


struct ForgotPasswordScreen_Previews: PreviewProvider {
	static var previews: some View {
		ForgotPasswordScreen()
	}
}
