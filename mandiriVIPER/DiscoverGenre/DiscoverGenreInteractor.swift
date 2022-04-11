//
//  DiscoverGenreInteractor.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation

protocol DiscoverGenreInteractorProtocol {
    var presenter : DiscoverGenrePresenterProtocol? {get set}
    func getMovies(with genreName : String, page: Int)
    
}
class DiscoverGenreInteractor : DiscoverGenreInteractorProtocol{
    var presenter: DiscoverGenrePresenterProtocol?
    
    func getMovies(with genreName: String, page : Int) {
        let conn : APIConnect = APIConnect()
        
        conn.discoverMovieByGenre(with: genreName, page: page) { movieResults, images in
            
                self.presenter?.interactorDidFetchMovies(with: movieResults, images: images)
            

        }
    }
}
