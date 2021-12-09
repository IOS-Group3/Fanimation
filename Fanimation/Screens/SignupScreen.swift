
/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  SignupScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
struct SignupScreen: View {
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@State private var email:String = ""
	@State private var password:String = ""
    @State private var username:String = ""
	@State var showPassword:Bool = false
	@State var errormessage:String = ""
    @State var loading:Bool = false
	
	init() {
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor:UIColor(named: "blue1") ?? UIColor.blue, .font: UIFont.systemFont(ofSize: 34, weight: .bold)]
	}
	
	var body: some View {
		ZStack {
			Color("light")
				.ignoresSafeArea()
			VStack {
                
                HStack {
                    Image(systemName: "person.fill")
                    TextField("Username", text: $username).autocapitalization(.none)
                }
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                .foregroundColor(Color("dark"))
                .padding(10)
				
				HStack {
					Image(systemName: "envelope.fill")
                    TextField("Email", text: $email).autocapitalization(.none)
				}
				.padding(.vertical, 10)
				.overlay(Rectangle().frame(height: 2).padding(.top, 35))
				.foregroundColor(Color("dark"))
				.padding(10)
				
				HStack {
					Image(systemName: "lock.fill")
					if showPassword {
                        TextField("Password", text: $password).autocapitalization(.none)
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
                //Error message
                Text(errormessage).foregroundColor(.red)
				Button(action: {
                    loading.toggle()
                    if username.count > 3 {
                         checkUsername(username: username) { result in
                             loading.toggle()
                            if result == true {
                                errormessage = ""
                                Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines)) {authResult, error in
                                    //Signup successful
                                    if (error == nil) {
                                        let uid = Auth.auth().currentUser?.uid
                                        
                                        createAccount(email: email, uid: uid!, username: username)
                                        goMain()
                                    }
                                    else {//Failure
                                        errormessage = error!.localizedDescription
                                    }
                                    
                                }
                            }
                            else {
                                errormessage = "Username is already taken. Please choose another."
                            }
                        }
                    }
                    else {
                        errormessage = "Username must be greater than 3 characters."
                    }
				}) {
                    if loading {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white)).scaleEffect(1).padding()
                            .frame(width: 300, height: 50)
                            .background(Color("blue1"))
                            .cornerRadius(20)
                            .foregroundColor(Color("light"))
                    }else {
                        Text("Signup")
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color("blue1"))
                            .cornerRadius(20)
                            .foregroundColor(Color("light"))
                    }
					
					
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
			}.padding()
				.navigationBarTitle(Text("Signup"), displayMode: .large)
        }.disabled(loading)
	}
}

func checkUsername(username: String, completion: @escaping (Bool) -> ()) -> () {
    let db = Firestore.firestore()
    
    db.collection("UsernameTaken").document(username.lowercased()).getDocument { DocumentSnapshot, error in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                completion(false)
            }
            else {
                if ((DocumentSnapshot?.exists) == true) {
                    print("Username does exist!")
                    completion(false)
                }
                else {
                    print("Username does not exist!")
                    completion(true)
                }
                
            }
        }

}
func createAccount(email: String, uid: String, username:String) {
	let db = Firestore.firestore()
    let defaultImage = "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fdefault.png?alt=media&token=0173621f-2d11-4f56-9716-b03c65f69b59"
	var ref: DocumentReference? = nil
	
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.displayName = username
    changeRequest?.photoURL = URL(string: defaultImage)
    changeRequest?.commitChanges()
    
	//Add user
    ref = db.collection("Users").document(email.lowercased())
	ref?.setData([
        "userID": uid,
        "username": username,
        "profileImage": defaultImage
	])
    
    //Add Username to list
    db.collection("UsernameTaken").document(username.lowercased()).setData([:
        
    ])
}

struct SignupScreen_Previews: PreviewProvider {
	static var previews: some View {
		SignupScreen()
	}
}
