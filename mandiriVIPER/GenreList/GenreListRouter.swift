//
//  GenreListRouter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation
import UIKit

protocol GenreRouter {
    var view :  GenreListView? { get }
    
    static func start() -> GenreRouter
    
    
}
class GenreListRouter : GenreRouter {
    var view: GenreListView?
    
    
    static func start() -> GenreRouter {
        let router = GenreListRouter()
        //vip here
        var presenter : GenreListPresenter = GenreListPresenter()
        var interactor : GenreListInteractor = GenreListInteractor()
        
        let storyboard = UIStoryboard(name: "GenreList", bundle: nil)
        let view : GenreListView = storyboard.instantiateViewController(withIdentifier: "GenreListView") as! GenreListView

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.view = view
        return router
    }
    
    
}
