//
//  MainScreen.swift
//  Fanimation
//
//  Created by Paola Jose on 11/13/21.
//

import SwiftUI
import Firebase
struct MainScreen: View {
    @State private var selection = 1
    
    init() {
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    var body: some View {
        TabView(selection: $selection) {
            ProfileScreen().tabItem{
                Label("Profile", systemImage: "person")
            }.tag(0)
            MyList().tabItem{
                Label("MyList", systemImage: "list.dash")
            }.tag(1)
            HomeScreen().tabItem {
                Label("Home", systemImage: "house")
            }.tag(2)
        }
    }
}


struct HomeScreen: View {
    var body: some View {
        Text("")
    }
}

struct MyList: View {
    var body: some View {
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

func onLogOut() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: WelcomeScreen())
        window.makeKeyAndVisible()
    }
}
struct ProfileScreen: View {
    var body: some View {
        Text("")
    }
}
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
