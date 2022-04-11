//
//  DiscoverGenrePresenter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation
import UIKit

protocol DiscoverGenrePresenterProtocol {
    var view : DiscoverGenreView? { get set }
    var router : DiscoverGenreRouter? {get set}
    var interactor : DiscoverGenreInteractor? {get set}
    
    func interactorDidFetchMovies(with results : MovieResult, images : [UIImage])
    func didSelectMovie(movieID : Int)
    
}

class DiscoverGenrePresenter : DiscoverGenrePresenterProtocol{
    var view: DiscoverGenreView?
    
    var router: DiscoverGenreRouter?
    var genreName : String?
    var interactor: DiscoverGenreInteractor?{
        didSet{
            interactor?.getMovies(with:genreName ?? "None" ,page: 1 )
        }
    }
    
    func interactorDidFetchMovies(with results : MovieResult, images : [UIImage]) {
        view?.updateMovieList(with: results, images: images)
    }
    
    func didSelectMovie(movieID: Int) {
    
    }
    
    
}

