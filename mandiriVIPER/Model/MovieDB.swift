//
//  MovieDB.swift
//  mandiriVIPER
//
//  Created by Aqshal on 09/04/22.
//

import Foundation

struct GenreList : Codable{
    let genres : [Genre]
}
struct Genre : Codable{
    let id : Int
    let name : String
}

struct MovieResult : Codable {
    let page : Int
    let results : [Movie]
    let total_pages : Int
}
struct Movie : Codable{
    let id : Int
    let original_title : String
    let overview : String
    let poster_path : String
}

struct MovieDetail : Codable {
    let id : Int
    let original_title : String
    let overview : String
    let poster_path : String
    let release_date : String
    let runtime :  Int
    let status : String
    let vote_average : Double
    let vote_count : Int
    
}

struct Video : Codable{
    let id : Int
    let results : [VideoDetail]
}

struct VideoDetail : Codable{
    let key : String
}

struct ReviewList : Codable {
    let page : Int
    let results : [Review]
    let total_pages : Int
    
}

struct Review : Codable {
    let author : String
    let content : String
}
