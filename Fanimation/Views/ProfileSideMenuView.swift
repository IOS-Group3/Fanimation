//
//  ProfileSideMenuView.swift
//  Fanimation
//
//  Created by Recleph on 12/7/21.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let icon: Image
    let action: () -> Void
}

struct ProfileSideMenuView: View {
    let width: CGFloat
    var menuOpen: Binding<Bool>
    var body: some View {
        ZStack {
            GeometryReader { reader in
                EmptyView()
                
            }.background(Color.black.opacity(0.4)).opacity(menuOpen.wrappedValue ? 1 : 0).animation(Animation.easeIn)
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    // Close menu
                    menuOpen.wrappedValue.toggle()
                }
            HStack {
                Spacer()
                MenuContent().frame(width: self.width).offset(x: menuOpen.wrappedValue ? 0 : -width)
                    .animation(.default)
            }
           
            
            
        }
    }
}

struct MenuContent: View {
    let menuItems:[MenuItem] = [
        MenuItem(
            text: "Update Avatar",
            icon: Image(systemName: "person.circle.fill"),
            action: updateAvatar
        ),
        
        MenuItem(
            text: "Change Password",
            icon: Image(systemName: "lock.fill"),
            action: changePassword
        ),
        
        MenuItem(
            text: "Change Privacy",
            icon: Image(systemName: "eye.slash.fill"),
            action: changePrivacy
        ),
        
        MenuItem(
            text: "Logout",
            icon: Image(systemName: "arrow.right.square"),
            action: logOut)
    
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 180, green: 202, blue: 245, alpha: 1)).edgesIgnoringSafeArea(.top)
            
            VStack (alignment: .leading){
                ForEach(menuItems) {
                    item in
                    VStack (alignment: .leading){
                        Button(action: item.action, label: {
                            HStack {
                                item.icon.foregroundColor(Color(UIColor(red: 29/255, green: 118/255, blue: 252/255, alpha: 1)))
                                Text(item.text).font(Font.custom("Poppins-Semibold", size: 14))
                            }.padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 20))
                        })
                        Divider().padding()
                    }
                }
                Spacer()
            }.padding(.top, 100)
        }
    }
}

func updateAvatar() -> Void {
    print("Updating Avatar")
    
}

func changePrivacy() -> Void {
    print("Changing Privacy")
}

func changePassword() -> Void {
    print("Changing Password")
}

func logOut() -> Void {
    let firebaseService = FirebaseRequests()
    firebaseService.logOut()
}



struct ProfileSideMenuView_Previews: PreviewProvider {
    static let menuToggle:Bool = true
    static var previews: some View {
        
        ProfileSideMenuBind()
    }
}

struct ProfileSideMenuBind: View {
    @State private var bind = true
    
    var body: some View {
        ProfileSideMenuView(width: UIScreen.main.bounds.width / 2, menuOpen: $bind)
    }
}
