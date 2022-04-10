//
//  APIConnect.swift
//  mandiriVIPER
//
//  Created by Aqshal on 09/04/22.
//

import Foundation

class APIConnect{
    private var apiKey = "90bfed73684adfe1cb42e711b04a482d"
    func getMovieGenreList(completion : @escaping (GenreList) -> Void){
        let newUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        print("attempting to acquire movie genre listlist...")
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var results : GenreList?
            do{
                results = try JSONDecoder().decode(GenreList.self, from: data)
            }catch{
            print("there was an error in decoding JSON")
          }
            guard let json = results else{
                print("No data from JSON")
                return
            }
            print("resulted in \(json.genres.count) genres")
            completion(json)
            
        }
        dataTask.resume()
    
    
    }

}
