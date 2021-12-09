/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  FirebaseRequests.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//  Last Modified by Recleph Mere on 12/06/21

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage
import grpc
import SwiftUI

public class FirebaseRequests {
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    let userEmail = Auth.auth().currentUser?.email
    
    func updateAvatar(imageData:URL) {
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
    
    // Function overload for uploading using Data instead of a URL ref
    func updateAvatar(imageData:Data, completed: @escaping() -> Void) {
        let user = Auth.auth().currentUser
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()

        // Create a storage reference from our storage service
        let storageRef = storage.reference().child("Users/\(user?.uid)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { storageData, error in
            if (error != nil) {
                print(error?.localizedDescription)
            }
            else {
                storageRef.downloadURL { url, error in
                    if error != nil {
                        return
                    }
                    if let urlString = url?.absoluteString {
                        self.updateUserProfile(photoURL: url!){
                            print("Finished Updating Account")
                            completed()
                        }
                    }
                }
            }
        }
        
    }


    func updateUserProfile(photoURL:URL, completed: @escaping () -> Void ) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = photoURL
        changeRequest?.commitChanges { error in
            if error != nil {
                print("\(error?.localizedDescription)")
                return
            }
            else {
                let ref = self.db.collection("Users").document(self.userEmail!)
                ref.updateData([
                    "profileImage": photoURL.absoluteString
                ])
                print("Update successful!")
                completed()
            }
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            onLogOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            
        }
        
    }
    
    func onLogOut() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: LoginScreen())
            window.makeKeyAndVisible()
        }
    }
    
    // Get User profile information
    func fetchUserProfile(completionHandler: @escaping (UserModel) -> Void) {
        
        db.collection("Users").document(userEmail!).getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Error while getting profile")
                return
            }
            let data = document.data()
            let usermodel = UserModel(id: data!["userID"] as! String, email: self.userEmail!, username: data!["username"] as! String, profilePicUrl: data!["profileImage"] as! String)
            print("Successfully fetched user info")
            completionHandler(usermodel)
            
        }
        
    }
    
    //Adds  the Anime to the appropriate list
    func AddToPlan(planning: PendingList) {
        do {
            try db.collection("Users").document(userEmail!).collection("Planning").document(String(planning.animeId)).setData(from: planning)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func AddToWatching(watching: WatchingList) {
        do {
            try db.collection("Users").document(userEmail!).collection("Watching").document(String(watching.animeId)).setData(from: watching)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func AddToCompleted(completed: CompletedList) {
        do {
            try db.collection("Users").document(userEmail!).collection("Completed").document(String(completed.animeId)).setData(from: completed)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    //Delete the anime from the appropriate list (Watching, Completed only)
    func DeleteAnime(animeId: Int, list: Int) {

        if list == 1 {
            db.collection("Users").document(userEmail!).collection("Watching").document(String(animeId)).delete() { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        }
        else if list == 2 {
            db.collection("Users").document(userEmail!).collection("Planning").document(String(animeId)).delete() { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        }
        else if list == 3 {
            db.collection("Users").document(userEmail!).collection("Completed").document(String(animeId)).delete() { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func getRatings(animeId:Int, completion: @escaping (Double, Int) -> ()) {
        getRatingsCompleted(animeId: animeId) { (avgComp, peopleComp) in
            self.getRatingsWatching(animeId: animeId) { (avgWatch, peopleWatch)  in
                
                let totalRating = avgComp + avgWatch
                let totalPeople = peopleComp + peopleWatch
                
                //Adding totalRating and totalPeople to avoid dividing by 0
                let average = totalRating + totalPeople > 0 ? Double(totalRating)/Double(totalPeople) : 0
                completion(average, totalPeople)
            }
        }
    }
    
    func getRatingsCompleted(animeId: Int, completion: @escaping (Int, Int) -> ()) {
        var avg:Int = 0
        var people:Int = 0
        db.collectionGroup("Completed").whereField("animeId", isEqualTo: animeId).whereField("score", isGreaterThan: -1).getDocuments() { (querySnapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                people = querySnapshot?.count ?? 0
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: Ratings.self)
                    }
                    switch result {
                        case .success(let rating):
                        if let rating = rating {
                            avg += rating.score
                        }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                            print(avg)
                            completion(avg, people)
                        }
                    }
                }
                completion(avg, people)
        }
    }
    }
    
    func getRatingsWatching(animeId:Int, completion: @escaping (Int, Int) -> ()) {
        var avg:Int = 0
        var people:Int = 0
        db.collectionGroup("Watching").whereField("animeId", isEqualTo: animeId).whereField("score", isGreaterThan: -1).getDocuments() { (querySnapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            else {
                people = querySnapshot?.count ?? 0
                for document in querySnapshot!.documents {
                    print("\(document)")
                    let result = Result {
                        try document.data(as: Ratings.self)
                    }
                    switch result {
                        case .success(let rating):
                        if let rating = rating {
                            avg += rating.score
                        }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                            completion(avg, people)
                        }
                    }
                }
                completion(avg, people)
        }
    }
    }
    
    func queryAnime(animeId:Int, animeTitle:String, imageURL: String, completion: @escaping (Settings) -> ()) ->() {
        let ref = db.collection("Users").document(userEmail!)
        ref.collection("Watching").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                
            }
            else {
                if QuerySnapshot!.count > 0 {
                    let result = Result {
                        try QuerySnapshot?.documents[0].data(as: WatchingList.self)
                    }
                    switch result {
                        case .success(let watch):
                            if let watch = watch {
                                ref.collection("Favorites").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
                                    if err != nil {
                                        
                                    } else {
                                        if QuerySnapshot!.count > 0 {
                                            let settings = Settings(animeId: animeId, animeTitle: watch.animeTitle, imageURL: imageURL, statusList: 1, isFavorited: true, scoreButton: watch.score, progressButton: watch.progress, startDate: watch.startDate)
                                            completion(settings)
                                        }
                                        else {
                                            let settings = Settings(animeId: animeId, animeTitle: watch.animeTitle, imageURL: imageURL, statusList: 1, isFavorited: false, scoreButton: watch.score, progressButton: watch.progress, startDate: watch.startDate)
                                            completion(settings)
                                        }
                                    }
                                }
                            }
                    case .failure(let error): do {
                            print(error.localizedDescription)
                    }
                }
                } else {
                    ref.collection("Planning").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
                        if err != nil {
                            
                        }
                        else {
                            if QuerySnapshot!.count > 0 {
                                let result = Result {
                                    try QuerySnapshot?.documents[0].data(as: PendingList.self)
                                }
                                switch result {
                                    case .success(let planning):
                                        if let planning = planning {
                                            ref.collection("Favorites").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
                                                if err != nil {
                                                    
                                                } else {
                                                    if QuerySnapshot!.count > 0 {
                                                        let settings = Settings(animeId: animeId, animeTitle: planning.animeTitle, imageURL: imageURL, statusList: 2, isFavorited: true)
                                                        completion(settings)
                                                    }
                                                    else {
                                                        let settings = Settings(animeId: animeId, animeTitle: planning.animeTitle, imageURL: imageURL, statusList: 2, isFavorited: false)
                                                        completion(settings)
                                                    }
                                                }
                                            }
                                        }
                                case .failure(let error): do {
                                        print(error.localizedDescription)
                                }
                            }
                            }
                            else {
                                ref.collection("Completed").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
                                    if err != nil {
                                        
                                    }
                                    else {
                                        if QuerySnapshot!.count > 0 {
                                            let result = Result {
                                                try QuerySnapshot?.documents[0].data(as: CompletedList.self)
                                            }
                                            switch result {
                                                case .success(let completed):
                                                    if let completed = completed {
                                                        ref.collection("Favorites").whereField("animeId", isEqualTo: animeId).getDocuments() { (QuerySnapshot, err) in
                                                            if err != nil {
                                                                
                                                            } else {
                                                                if QuerySnapshot!.count > 0 {
                                                                    let settings = Settings(animeId: animeId, animeTitle: completed.animeTitle, imageURL: imageURL, statusList: 3, isFavorited: true, scoreButton: completed.score, startDate: completed.startDate, endDate: completed.endDate)
                                                                    completion(settings)
                                                                }
                                                                else {
                                                                    let settings = Settings(animeId: animeId, animeTitle: completed.animeTitle, imageURL: imageURL, statusList: 3, isFavorited: false, scoreButton: completed.score, startDate: completed.startDate, endDate: completed.endDate)
                                                                    completion(settings)
                                                                }
                                                            }
                                                        }
                                                    }
                                            case .failure(let error): do {
                                                    print(error.localizedDescription)
                                            }
                                        }
                                        }
                                        else {
                                            let settings = Settings(animeId: animeId, animeTitle: animeTitle, imageURL: imageURL)
                                            completion(settings)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    //Updates the favorites list
    func UpdateFavorites(add:Bool, favorites: FavoritedAnime) {
        if add {
            do {
                try db.collection("Users").document(userEmail!).collection("Favorites").document(String(favorites.animeId)).setData(from: favorites)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        else {
            db.collection("Users").document(userEmail!).collection("Favorites").document(String(favorites.animeId)).delete() { err in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func getCollectionCounts(completion: @escaping([Int]) -> ()) {
        var counts = [Int]()
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            
            
            self.fetchWatchingList {
                list in
                counts.append(list.count)
                semaphore.signal()
                
            }
            
            semaphore.wait()
            
            self.fetchCompletedList {
                list in
                counts.append(list.count)
                semaphore.signal()
            }
            
            semaphore.wait()
            
            self.fetchPendingList {
                list in
                counts.append(list.count)
                semaphore.signal()
            }
            
            semaphore.wait()
            
            completion(counts)
            
        }
    }
        
    func fetchFavoritedList(completion: @escaping ([FavoritedAnime]) -> Void) {
        let ref = db.collection("Users").document(userEmail!)
        var favoritesList = [FavoritedAnime]()
        
        ref.collection("Favorites").getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                
            }
            else {
                for document in QuerySnapshot!.documents {
                    let result = Result {
                        try document.data(as: FavoritedAnime.self)
                    }
                    switch result {
                        case .success(let favorites):
                            if let favorites = favorites {
                                favoritesList.append(favorites)
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                }
                completion(favoritesList)
            }
        }
        
    }
    
    // Retrieve Watching Collection
    func fetchWatchingList(completion: @escaping ([WatchingList]) -> Void) {
        let ref = db.collection("Users").document(userEmail!)
        var watchingList = [WatchingList]()
        
        ref.collection("Watching").getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                
            }
            else {
                for document in QuerySnapshot!.documents {
                    let result = Result {
                        try document.data(as: WatchingList.self)
                    }
                    switch result {
                        case .success(let watching):
                            if let watching = watching {
                                watchingList.append(watching)
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                }
                completion(watchingList)
            }
        }
    }
    
    //Retrieve Planning
    func fetchPendingList(completion: @escaping ([PendingList]) -> () ) {
        let ref = db.collection("Users").document(userEmail!)
        var pendingList:[PendingList] = []
        
        ref.collection("Planning").getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print(err?.localizedDescription)

            }
            else {
                for document in QuerySnapshot!.documents {
                    let result = Result {
                        try document.data(as: PendingList.self)
                    }
                    switch result {
                        case .success(let planning):
                            if let planning = planning {
                                pendingList.append(planning)
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                }
                completion(pendingList)
            }
        }
    }
    
    func updateProgress(animeId:Int, progress:Int, completion: @escaping (Bool) -> ()) {
        let ref = db.collection("Users").document(userEmail!)
        
        ref.collection("Watching").document(String(animeId)).updateData([
            "progress": progress]) { err in
            if let err = err  {
                print(err.localizedDescription)
                completion(false)
            }
            else {
                print("Document updated")
                completion(true)
            }
        }
    }
    //Retrieve Completed
    func fetchCompletedList(completion: @escaping ([CompletedList]) -> ()) {
        let ref = db.collection("Users").document(userEmail!)
        var completedList:[CompletedList] = []
        
        ref.collection("Completed").getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print(err?.localizedDescription)
            }
            else {
                for document in QuerySnapshot!.documents {
                    let result = Result {
                        try document.data(as: CompletedList.self)
                    }
                    switch result {
                        case .success(let completed):
                            if let completed = completed {
                                completedList.append(completed)
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                }
                completion(completedList)
            }
        }
    }
}
