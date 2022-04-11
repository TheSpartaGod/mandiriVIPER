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
