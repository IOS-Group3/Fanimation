/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  FanimationApp.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/27/21.
//

import SwiftUI
import Firebase

@main
struct FanimationApp: App {
	init () {
		FirebaseApp.configure()
	}
	var body: some Scene {
		WindowGroup {
			NavigationView {
				LaunchScreen()
					.navigationBarTitle("")
					.navigationBarHidden(true)
					.navigationBarBackButtonHidden(true)
			}
		}
	}
}
