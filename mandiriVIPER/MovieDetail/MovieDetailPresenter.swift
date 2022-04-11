//
//  MovieDetailPresenter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation
import UIKit

protocol MovieDetailPresenterProtocol {
    var router : MovieDetailRouterProtocol? {get set}
    var interactor : MovieDetailInteractorProtocol? {get set}
    var view : MovieDetailViewProtocol? {get set}
    func interactorHasRetrievedDetail(detail : MovieDetail, image: UIImage, link : String, reviews : [Review])
    var movieID : Int? {get set}
    
}
class MovieDetailPresenter : MovieDetailPresenterProtocol{
    
    var router: MovieDetailRouterProtocol?
    var view: MovieDetailViewProtocol?
    var movieID: Int?
    var interactor: MovieDetailInteractorProtocol?{
        didSet{
            interactor?.getMovieDetails(id: movieID ?? 0)
        }
    }
    
    func interactorHasRetrievedDetail(detail: MovieDetail, image: UIImage, link : String, reviews : [Review]) {
        view?.movieInfo = detail
        view?.posterImage = image
        view?.trailerLink = link
        view?.reviews = reviews
        print("added trailer link of \(link)")
        view?.updateAllViews()
        
    }
    
    
    
}
