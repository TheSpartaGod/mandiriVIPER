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
