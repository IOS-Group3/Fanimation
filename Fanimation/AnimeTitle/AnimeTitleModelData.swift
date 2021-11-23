//
//  AnimeTitleModelData.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/17/21.
//

import Foundation
import FirebaseFirestore

//TODO: add the link
var AnimeTitles: [AnimeTitleModel] = fetchAnimeTitles(link: "")
func fetchAnimeTitles<T: Decodable>(link:String) -> T {
	var data: Data = Data()
	let url = URL(string: link)
	
	
	
	URLSession.shared.dataTask(with: url!) { titles, _, error in
		if error == nil {
			data = titles!
		} else {
			fatalError("could not fetch data!")
		}
		
	}.resume()
	
	do {
		let decoder = JSONDecoder()
		return try decoder.decode(T.self, from: data)
	} catch {
		fatalError("could not parse data")
	}
}
