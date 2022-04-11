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
    func getReviews(with movieID : Int, page : Int, completion : @escaping ([Review]) -> Void){
        let newUrl = "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=90bfed73684adfe1cb42e711b04a482d&language=en-US&page=\(page)"
        
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var results : ReviewList?
            do{
                results = try JSONDecoder().decode(ReviewList.self, from: data)
            }catch{
            print("there was an error in decoding JSON")
          }
            guard let json = results else{
                print("No data from JSON")
                return
            }
            completion(json.results)
        }
        dataTask.resume()
        
        
    }
    
    func getMovieDetail(with movieID : Int, completion : @escaping (MovieDetail, [UIImage], String) -> Void){
        let newUrl = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&language=en-US"
        
        print("attempting to acquire movie detail list...")
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var results : MovieDetail?
            do{
                results = try JSONDecoder().decode(MovieDetail.self, from: data)
            }catch{
            print("there was an error in decoding JSON")
          }
            guard let json = results else{
                print("No data from JSON")
                return
            }
            var images : [UIImage] = []
            DispatchQueue.main.async {
                self.getImage(with: json.poster_path) { image in
                    images.append(image)
                    self.getYTVideo(with: json.id) { link in
                        completion(json, images, link)
                    }
                    
                }
              
            }
        }
        dataTask.resume()
        
    }
    func getYTVideo(with movieID : Int, completion : @escaping (String) -> Void){
        let newUrl = "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=\(apiKey)&language=en-US"
        var request = URLRequest(url: URL(string: newUrl)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                print("there was something wrong while fetching data")
                return
            }
            var results : Video?
            do{
                results = try JSONDecoder().decode(Video.self, from: data)
            }catch{
            print("there was an error in decoding JSON")
          }
            guard let json = results else{
                print("No data from JSON")
                return
            }
            DispatchQueue.main.async {
                let key = json.results[0].key //always get the no. 0 because it is youtube
                completion(key)
                
              
            }
        }
        dataTask.resume()
    }

}
