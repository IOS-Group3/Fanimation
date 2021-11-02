//
//  SignupScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI

struct SignupScreen: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@State private var email:String = ""
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
					//TODO: add functionality to the signup button
				}) {
					
					Text("Signup")
						.padding()
						.frame(width: 300, height: 50)
						.background(Color("blue1"))
						.cornerRadius(20)
						.foregroundColor(Color("light"))
				}
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

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen()
    }
}
