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
			LaunchScreen()
        }
    }
}
