//
//  GenreListPresenter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation
import UIKit

protocol GenrePresenterProtocol{
    var router : GenreRouterProtocol? {get set}
    var interactor : GenreInteractorProtocol? {get set}
    var view : GenreListViewProtocol? {get set}
    
    func interactorDidFetchGenre(with result: [Genre])
    func didSelectGenre(genreName : String, from view: UIViewController)
}

class GenreListPresenter : GenrePresenterProtocol{

    
    var interactor: GenreInteractorProtocol? {
        didSet {
            interactor?.getGenres()
        }
    }
    
    var view: GenreListViewProtocol?
    
    var router: GenreRouterProtocol?
    
    func interactorDidFetchGenre(with result: [Genre]) {
        print("got fetched")
        view?.update(with: result)
    }
    func didSelectGenre(genreName : String, from view: UIViewController) {
        print("got genre name : \(genreName)")
        router?.presentDiscover(with: genreName, from: view)
    }
    
}
