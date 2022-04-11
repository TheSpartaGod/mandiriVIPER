//
//  GenreListInteractor.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation

protocol GenreInteractorProtocol{
    var presenter : GenrePresenterProtocol? {get set}
    
    func getGenres()
    

}

class GenreListInteractor : GenreInteractorProtocol{
    var presenter: GenrePresenterProtocol?
    
    func getGenres() {
    let conn : APIConnect = APIConnect()
        conn.getMovieGenreList { [self] genreList in
            presenter?.interactorDidFetchGenre(with: genreList.genres)
        }
    }
    
    
}
