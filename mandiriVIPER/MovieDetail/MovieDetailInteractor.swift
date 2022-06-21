//
//  MovieDetailInteractor.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation

protocol MovieDetailInteractorProtocol : AnyObject {
    var presenter : MovieDetailPresenterProtocol? {get set}
    func getMovieDetails(id : Int)
    func getMovieReviews(id : Int, page : Int) -> [Review]

}
class MovieDetailInteractor : MovieDetailInteractorProtocol {
    weak var presenter : MovieDetailPresenterProtocol?
    let conn : APIConnect = APIConnect()
    
    func getMovieDetails(id: Int){
        conn.getMovieDetail(with: id) { detail, images, link in
            self.conn.getReviews(with: id, page: 1) { list in
                self.presenter?.interactorHasRetrievedDetail(detail: detail, image: images[0], link: link, reviews: list)
            }
        }
    }
    
    func getMovieReviews(id: Int, page : Int) -> [Review]{
        var reviewList : [Review] = []
        conn.getReviews(with: id, page: page) { list in
            reviewList = list
        }
        return reviewList
    }
    
    
}
