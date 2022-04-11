//
//  APIConnect.swift
//  mandiriVIPER
//
//  Created by Aqshal on 09/04/22.
//

import Foundation
import UIKit

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
    func discoverMovieByGenre(with genreName : String, page: Int, completion : @escaping (MovieResult, [UIImage]) -> Void){
        let newUrl = "https://api.themoviedb.org/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(String(page))&with_genres=\(genreName)&with_watch_monetization_types=flatrate"
        print("attempting to acquire movie list...")
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var results : MovieResult?
            var images : [UIImage] = []
            do{
                results = try JSONDecoder().decode(MovieResult.self, from: data)
            }catch{
            print("there was an error in decoding JSON")
          }
            guard let json = results else{
                print("No data from JSON")
                return
            }
            print("resulted in \(json.results.count) movies")
            
       
                for i in json.results{
                    self.getImage(with: i.poster_path) { image in
                        images.append(image)
                        print("appended image")
                        print("image count : \(images.count)")
                        if json.results.count == images.count {
                            completion(json, images)
                        }
                    }
                  
                        print("image count : \(images.count)")
                        
                    
                }
               
                
            
           
            
        }
        dataTask.resume()
    }
    func getImage(with imageLink : String, completion : @escaping (UIImage) -> Void){
        let newUrl = "https://image.tmdb.org/t/p/w500\(imageLink)"
        
        var finalImage : UIImage = UIImage()
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var resultImage : UIImage?
            resultImage = UIImage(data: data)
        
            guard let finalResult = resultImage else{
                print("No data from JSON")
                return
            }
            finalImage = finalResult
            completion(finalImage)
            
        }
        dataTask.resume()
    }

}
