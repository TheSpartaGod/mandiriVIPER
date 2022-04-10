//
//  GenreListPresenter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation

protocol GenrePresenter{
    var router : GenreRouter? {get set}
    var interactor : GenreInteractor? {get set}
    var view : GenreListViewProtocol? {get set}
    
    func interactorDidFetchGenre(with result: [Genre])
    func didSelectGenre(genreID : Int)
}

class GenreListPresenter : GenrePresenter{
    
    
    
    
    var interactor: GenreInteractor? {
        didSet {
            interactor?.getGenres()
        }
    }
    

    
    var view: GenreListViewProtocol?
    
    var router: GenreRouter?
    
    func interactorDidFetchGenre(with result: [Genre]) {
        print("got fetched")
        view?.update(with: result)
    }
    func didSelectGenre(genreID : Int) {
        
    }
    
}
