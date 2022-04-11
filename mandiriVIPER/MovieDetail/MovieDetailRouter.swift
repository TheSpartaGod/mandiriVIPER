//
//  MovieDetailRouter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    var entryView : MovieDetailView? {get}
    var presenter : MovieDetailPresenterProtocol? {get set}
    static func start(with movie : Movie) -> MovieDetailRouterProtocol
    
}
class MovieDetailRouter : MovieDetailRouterProtocol{
    var presenter: MovieDetailPresenterProtocol?
    var entryView: MovieDetailView?
    
    static func start(with movie : Movie) -> MovieDetailRouterProtocol {
        let router = MovieDetailRouter()
        let presenter : MovieDetailPresenter = MovieDetailPresenter()
        let interactor : MovieDetailInteractor = MovieDetailInteractor()
        
        let storyboard = UIStoryboard(name: "MovieDetailView", bundle: nil)
        let view : MovieDetailView = storyboard.instantiateViewController(withIdentifier: "MovieDetailView") as! MovieDetailView
        
        presenter.movieID = movie.id
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        router.entryView = view
    
        return router
    }
}
