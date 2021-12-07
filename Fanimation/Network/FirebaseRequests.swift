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
import grpc
import SwiftUI

public class FirebaseRequests {
    let db = Firestore.firestore()
    var ref: DocumentReference? = nil
    let userEmail = Auth.auth().currentUser?.email
    
    
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

    func queryAnime(animeId:Int, animeTitle:String, pending:[PendingList], watching:[WatchingList], completed:[CompletedList], favorites:[FavoriteList]) -> (Settings) {
        var current:Settings?
        
        if watching.contains(where: {$0.animeId == animeId}) {
            //get item
            if let item = watching.first(where: {$0.animeId == animeId}) {
                //Check favorites, don't retrieve
                if favorites.contains(where: {$0.animeId == animeId}) {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 1, isFavorited: true, scoreButton: item.score, progressButton: item.progress)
                }
                else {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 1, isFavorited: false, scoreButton: item.score, progressButton: item.progress)
                }
            } else {
                current = Settings(animeId: animeId, animeTitle: animeTitle)
            }
        }
        else if pending.contains(where: {$0.animeId == animeId}) {
            //get item
            if let item = pending.first(where: {$0.animeId == animeId}) {
                //Check favorites, don't retrieve
                if favorites.contains(where: {$0.animeId == animeId}) {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 2, isFavorited: true)
                }
                else {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 2, isFavorited: false)
                }
            } else {
                current = Settings(animeId: animeId, animeTitle: animeTitle)
            }
        }
        else if completed.contains(where: {$0.animeId == animeId}) {
            //get item
            if let item = completed.first(where: {$0.animeId == animeId}) {
                //Check favorites, don't retrieve
                if completed.contains(where: {$0.animeId == animeId}) {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 1, isFavorited: true, scoreButton: item.score)
                }
                else {
                    //Create currSettings
                    current = Settings(animeId: item.animeId, animeTitle: item.animeTitle, statusList: 1, isFavorited: false, scoreButton: item.score)
                }
            }else {
                current = Settings(animeId: animeId, animeTitle: animeTitle)
            }
        }
        
        return current!
        
    }
    //Updates the favorites list
    func UpdateFavorites(add:Bool, favorites: FavoriteList) {
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
    
    //Snapshot Watching
    //Snapshot Pending
    
    //Snapshot Completed
    
    //Snapshot Favorites
    
    //Retrieves the new users list (tuples)
    func RetrieveWatching() -> ([WatchingList]) {
        var leave = 0
        let ref = db.collection("Users").document(userEmail!)
        var watchingList:[WatchingList] = []
        //Watching

        ref.collection("Watching").getDocuments() { (QuerySnapshot, err) in
            if err != nil {
                print(err?.localizedDescription)
            }
            else {
                for document in QuerySnapshot!.documents {
                    
                        let result = Result {
                            try document.data(as: WatchingList.self)
                        }
                        switch result {
                            case .success(let watch):
                                if let watch = watch {
                                    watchingList.append(watch)
                                }
                                else {
                                    
                                }
                            case .failure(let error): do {
                                print(error.localizedDescription)
                                              }
                      }
                    }
                }
            
                print("\(watchingList) ")
        }
            
         print("End. ")
            return watchingList
        
        
    }
    
    func RetrievePending() -> ([PendingList]) {
        let ref = db.collection("Users").document(userEmail!)
        var pendingList:[PendingList] = []
        
        //Pending List
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
                        else {
                            
                        }
                    case .failure(let error): do {
                        print(error.localizedDescription)
                    }
                }
                }
            }
        }
        
        return pendingList
    }
    func RetrieveCompleted() -> ([CompletedList]) {
        let ref = db.collection("Users").document(userEmail!)
        var completedList:[CompletedList] = []
        
        //Completed List
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
                        else {
                            
                        }
                    case .failure(let error): do {
                        print(error.localizedDescription)
                    }
                }
                }
            }
        }
        
        return completedList
    }
    
    func RetrieveFavorites() -> ([FavoriteList]) {
        let ref = db.collection("Users").document(userEmail!)
        var favoritesList:[FavoriteList]  = []
        
        //Favorites List
        DispatchQueue.main.async {
            
            ref.collection("Favorites").getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    
                }
                else {
                    for document in QuerySnapshot!.documents {
                        let result = Result {
                            try document.data(as: FavoriteList.self)
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
                }
                Dispatch.wait()
            }
        }
        
        return favoritesList
     }
    
    func RetrieveLists(watchingList: Binding<[WatchingList]>, pendingList: Binding<[PendingList]>, completedList: Binding<[CompletedList]>, favoritesList:Binding<[FavoriteList]>) -> () {
        let ref = db.collection("Users").document(userEmail!)
        
        DispatchQueue.global(qos: .default).async {
            ref.collection("Watching").getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    print(err?.localizedDescription)

                }
                else {
                    for document in QuerySnapshot!.documents {
                        let result = Result {
                            try document.data(as: WatchingList.self)
                    }
                    switch result {
                        case .success(let watch):
                            if let watch = watch {
                                watchingList.wrappedValue.append(watch)
                            }
                            else {
                                    
                            }
                        case .failure(let error): do {
                                print(error.localizedDescription)

                        }
                    }
                }
                        
                    print("\(watchingList) ")
            }
        }

        }
            
            //Pending List
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
                                pendingList.wrappedValue.append(planning)
                            }
                            else {
                                
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                    }
                }
            }
            
            //Completed List
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
                                completedList.wrappedValue.append(completed)
                            }
                            else {
                                
                            }
                        case .failure(let error): do {
                            print(error.localizedDescription)
                        }
                    }
                    }
                }
            }
            
            //Favorites List
            ref.collection("Favorites").getDocuments() { (QuerySnapshot, err) in
                if err != nil {
                    
                }
                else {
                    for document in QuerySnapshot!.documents {
                        let result = Result {
                            try document.data(as: FavoriteList.self)
                        }
                        switch result {
                            case .success(let favorites):
                                if let favorites = favorites {
                                    favoritesList.wrappedValue.append(favorites)
                                }
                            case .failure(let error): do {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
         }
}

