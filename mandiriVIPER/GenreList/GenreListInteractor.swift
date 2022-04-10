//
//  GenreListInteractor.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation

protocol GenreInteractor{
    var presenter : GenrePresenter? {get set}
    
    func getGenres()
    

}

class GenreListInteractor : GenreInteractor{
    var presenter: GenrePresenter?
    
    func getGenres() {
    let conn : APIConnect = APIConnect()
        conn.getMovieGenreList { [self] genreList in
            presenter?.interactorDidFetchGenre(with: genreList.genres)
        }
    }
    
    
}
