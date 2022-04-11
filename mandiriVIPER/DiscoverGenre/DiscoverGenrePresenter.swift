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
    var genreName : String? {get set}
    
    func interactorDidFetchMovies(with results : MovieResult, images : [UIImage])
    func didSelectMovie(movie : Movie)
    func loadMoreMovies(page : Int)
    
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
        view?.movieList?.append(contentsOf: results.results)
        view?.imageList?.append(contentsOf: images)
        //update the table if page is 1, else append.
        view?.page == 1 ? view?.updateMovieList() : view?.appendMovieList()
        
    }
   
    
    func didSelectMovie(movie : Movie) {
        router?.presentMovieDetail(with: movie, from: view!)
    }
    func loadMoreMovies(page : Int) {
        interactor?.getMovies(with: genreName ?? "None", page: page)
    }
    
    
    
}

