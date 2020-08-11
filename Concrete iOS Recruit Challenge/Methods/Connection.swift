//
//  Connection.swift
//  Concrete iOS Recruit Challenge
//
//  Created by Fagner Caetano on 10/08/20.
//

import UIKit

class Connection: NSObject {
    
    var movies: [NSDictionary]?
    
    func fetchMovies(completion: @escaping([NSDictionary]?) -> Void) {
        let apiKey = "7ee4bda0351891ff932d1560ae68ce97"
        let language = "pt-BR"
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=\(language)&page=1") else { return }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    print("response: \(String(describing: self.movies))")
                    completion(self.movies)
                }
            }
        }
        task.resume()
    }

}
