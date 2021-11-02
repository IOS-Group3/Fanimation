//
//  MainScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI

struct ForgotPasswordScreen: View {
	@State private var email:String = ""
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
				
				
//				Spacer()
				Button(action: {
					//TODO: add functionality to the forgot password button
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
