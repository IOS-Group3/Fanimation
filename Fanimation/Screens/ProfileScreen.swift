//
//  ProfileScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified by Recleph Mere on 12/04/21

import SwiftUI
import Firebase
import FirebaseStorage
struct ProfileScreen: View {
    let anime = Anime()
    let firebaseServices = FirebaseRequests()
    let popularity_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    @State var watchingCount: Int = 13
    @State var completedCount: Int = 21
    @State var plantoWatchCount: Int = 15
    @State var totalCount: Int = 0
    

    @State var watchingWidth: Int = 0
    @State var completedWidth: Int = 0
    
    @State var favoriteList = [Anime]()
    
    @State var user = UserModel()
    @State var profilePic = "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fblank.png?alt=media&token=c1a5957e-aa94-4ff8-84df-d298aa2567e9"
    @State var loading = true
    @State var joinedDate = "2021"
    
    func calculateProgress() {
        totalCount = watchingCount + completedCount + plantoWatchCount
        watchingWidth = Int(((Double(watchingCount) / Double(totalCount)) * 200.0).rounded(.down))
        completedWidth = Int(((Double(completedCount) / Double(totalCount)) * 200.0).rounded(.down))
    }
    
    func initialize() {
        firebaseServices.fetchUserProfile() { user in
            self.user = user
            self.profilePic = self.user.profilePicUrl
            
            let firebaseAuth = Auth.auth()
            let date = firebaseAuth.currentUser!.metadata.creationDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            self.joinedDate = dateFormatter.string(from: date)
            
            loading = false
            
        }
        
        calculateProgress()
        
    }
	var body: some View {
        NavigationView {
            ScrollView {
                ZStack (alignment: .topLeading){
                    // Increase height of background by drag amount
                    GeometryReader { g in
                        Image("geo-landscape-valley").resizable().aspectRatio(1, contentMode: .fill)
                            .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                            .frame(width:UIScreen.main.bounds.width, height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / 1.5 + g.frame(in: .global).minY : UIScreen.main.bounds.height / 1.5).ignoresSafeArea(.all)
                        
                    }.frame(height: UIScreen.main.bounds.height / 1.5)
                    HStack {
                        Spacer()
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.white).frame(height: 140)
                                    .padding(EdgeInsets(top: 150, leading: 20, bottom: 0, trailing: 20)).shadow(color: Color.black.opacity(0.7), radius: 4, x: 1, y: 1)
                                HStack {
                                    if loading {
                                        ProgressView().frame(width: 130, height: 200).cornerRadius(15).padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0)).shadow(radius: 10)
                                        
                                    } else {
                                    AsyncImage(
                                        url: URL(string: profilePic)!, placeholder: { LoadingCard() },
                                        image: {
                                            Image(uiImage: $0).resizable()
                                        }
                                    ).frame(width: 130, height: 200).cornerRadius(15).padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0)).shadow(radius: 10)
                                    }
                                    //Spacer()
                                    VStack (alignment: .leading){
                                        Text(user.username).font(Font.custom("Poppins-SemiBold", size: 18))
                                        Text("Joined " +  joinedDate).font(Font.custom("Poppins-Regular", size: 14))
                                    }.padding(EdgeInsets(top: 120, leading: 10, bottom: 0, trailing: 0))
                                    Spacer()
                                }
                            }
                            ZStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.white).frame(height: 250)
                                    .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)).shadow(color: Color.black.opacity(0.7), radius: 4, x: 1, y: 1)
                                VStack (alignment: .leading){
                                    Text("Anime stats").padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 20)).font(Font.custom("Poppins-SemiBold", size: 20))
                                    HStack {
                                        VStack (alignment: .leading) {
                                            Circle().fill(Color.purple).frame(width: 12, height: 12).padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0))
                                            Circle().fill(Color.green).frame(width: 12, height: 12).padding(EdgeInsets(top: 15, leading: 40, bottom: 0, trailing: 0))
                                            Circle().fill(Color.gray).frame(width: 12, height: 12).padding(EdgeInsets(top: 15, leading: 40, bottom: 0, trailing: 0))
                                        }
                                        VStack (alignment: .leading){
                                            Text("Watching").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        
                                            Text("Completed").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        
                                            Text("Plan to Watch").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        }
                                        VStack (alignment: .trailing){
                                            Text("\(watchingCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        
                                            Text("\(completedCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        
                                            Text("\(plantoWatchCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                        }
                                    }
                                    HStack {
                                        Spacer()
                                        ZStack (alignment: .leading){
                                            // Plan to Watch percentage
                                            RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.gray.opacity(0.9)).frame(width: 200, height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                            // Completed Percentage
                                            RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.green).frame(width: CGFloat(watchingWidth) + CGFloat(completedWidth), height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                            // Watching percentage
                                            RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.purple).frame(width: CGFloat( watchingWidth), height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                        
                                        }
                                        Spacer()
                                    }
                                
                                }
                            }
                            // TODO: Update AnimeListView to pull from DB when URL is null or title is 'Favourites'
                            AnimeListView(url: popularity_url!, title: "Favourites")
                            
                        }
                        Spacer()
                    }.padding(.top, 120)
                }
            }.edgesIgnoringSafeArea(.top)
                .onAppear(perform: initialize).toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("Saved tapped")
                    } label: {
                        Image(systemName: "bell").foregroundColor(Color.black)
                    }
                    
                    Button {
                        print("Settings tapped")
                    } label : {
                        Image(systemName: "gearshape").foregroundColor(Color.black)
                    }
                }
            }
            
        }
    }

//    var body: some View {
//		Text("Profile screen")
//		Button("Logout") {
//			let firebaseAuth = Auth.auth()
//			do {
//				try firebaseAuth.signOut()
//				onLogOut()
//			} catch let signOutError as NSError {
//				print("Error signing out: %@", signOutError)
//			}
//			
//		}.padding()
//			.frame(width: 300, height: 50)
//			.background(Color("blue1"))
//			.cornerRadius(20)
//			.foregroundColor(Color("light"))
//	}

}

struct ProfileScreen_Previews: PreviewProvider {
	static var previews: some View {
		ProfileScreen()
	}
}


//Here's a link for reference:https://firebase.google.com/docs/storage/ios/upload-files
func uploadProfile(imageData:URL) {
    let user = Auth.auth().currentUser
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()

    // Create a storage reference from our storage service
    let storageRef = storage.reference().child("Users/\(user?.uid)")
    
    storageRef.putFile(from: imageData, metadata: nil) { storageData, error in
        if (error != nil) {
            print(error?.localizedDescription)
        }
        else {
            storageRef.downloadURL { url, error in
                if error != nil {
                    return
                }
                let urlString = url?.absoluteString
            }
        }
    }
    
}
func onLogOut() {
	if let window = UIApplication.shared.windows.first {
		window.rootViewController = UIHostingController(rootView: WelcomeScreen())
		window.makeKeyAndVisible()
	}
}

func updateUserProfile(photoURL:URL) {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.photoURL = photoURL
    changeRequest?.commitChanges { error in
        if error != nil {
            print("\(error?.localizedDescription)")
        }
        else {
            print("Update successful!")
        }
    }
}
