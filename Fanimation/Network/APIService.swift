//
//  APIService.swift
//  Fanimation
//
//  Created by Recleph on 11/20/21.
//

import Foundation

struct APIService {
    
    func fetchAnimeTitle(url: URL?, completion: @escaping(Result<Anime, Error>) -> Void) {
        
        guard let url = url else {
            // Show Error
            print("Could not invoke url")
            completion(Result.failure(assertionFailure("Could not invoke url") as! Error))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                if let decodedResponse = try?
                    JSONDecoder().decode(Anime.self, from: data) {
                    // Json decoder run in background thread so return to main thread
                    DispatchQueue.main.async {
                        completion(Result.success(decodedResponse))
                    }
                    return
                }
                
            }
            print("Failed to Fetch data: \(String(describing: error?.localizedDescription))")
                  
        }.resume()
        
    }
    
    func fetchAnimeList(url: URL?, completion: @escaping(Result<[Anime], Error>) -> Void) {
        
        guard let url = url else {
            // Show Error
            print("Could not invoke url")
            completion(Result.failure(assertionFailure("Could not invoke url") as! Error))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                if let decodedResponse = try?
                    JSONDecoder().decode(Response.self, from: data) {
                    // Json decoder run in background thread so return to main thread
                    DispatchQueue.main.async {
                        completion(Result.success(decodedResponse.top))
                    }
                    return
                }
                
            }
            print("Failed to Fetch data: \(String(describing: error?.localizedDescription))")
                  
        }.resume()
        
    }
    
    
    func fetchDiscoverAnimeList(url: URL?, completion: @escaping(Result<[Anime], Error>) -> Void) {
        
        guard let url = url else {
            // Show Error
            print("Could not invoke url")
            completion(Result.failure(assertionFailure("Could not invoke url") as! Error))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                if let decodedResponse = try?
                    JSONDecoder().decode(Discover.self, from: data) {
                    // Json decoder run in background thread so return to main thread
                    DispatchQueue.main.async {
                        completion(Result.success(decodedResponse.results))
                    }
                    return
                }
                
            }
            print("Failed to Fetch data: \(String(describing: error?.localizedDescription))")
                  
        }.resume()
        
    }
}
