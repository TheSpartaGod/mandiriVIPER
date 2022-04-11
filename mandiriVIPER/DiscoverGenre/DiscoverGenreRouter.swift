//
//  DiscoverGenreRouter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import Foundation
import UIKit

protocol DiscoverGenreRouterProtocol{
    var entryView : DiscoverGenreView? {get}
    
    static func start(with genreName : String) -> DiscoverGenreRouterProtocol
    
    
    
}

class DiscoverGenreRouter : DiscoverGenreRouterProtocol {
   
    var entryView: DiscoverGenreView?
    //var discoverGenreName : String?
    static func start(with genreName : String) -> DiscoverGenreRouterProtocol {
        
        let router = DiscoverGenreRouter()
        
        let presenter : DiscoverGenrePresenter = DiscoverGenrePresenter()
        let interactor : DiscoverGenreInteractor = DiscoverGenreInteractor()
        
        let storyboard = UIStoryboard(name: "DiscoverGenreView", bundle: nil)
        let view : DiscoverGenreView = storyboard.instantiateViewController(withIdentifier: "DiscoverGenreView") as! DiscoverGenreView
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        router.entryView = view
        return router
    }
    
    
    
    
    
}
