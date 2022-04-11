//
//  GenreListRouter.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 10/04/22.
//

import Foundation
import UIKit

protocol GenreRouterProtocol {
    var entryView :  GenreListView? { get }
    
    static func start() -> GenreRouterProtocol
    
    func presentDiscover(with name : String, from view : UIViewController)
}
class GenreListRouter : GenreRouterProtocol {
    var entryView: GenreListView?
    static var navigationController : UINavigationController?
    static func start() -> GenreRouterProtocol {
        let router = GenreListRouter()
        //vip here
        let presenter : GenreListPresenter = GenreListPresenter()
        let interactor : GenreListInteractor = GenreListInteractor()
        
        let storyboard = UIStoryboard(name: "GenreList", bundle: nil)
        let view : GenreListView = storyboard.instantiateViewController(withIdentifier: "GenreListView") as! GenreListView

        router.entryView = view
        interactor.presenter = presenter
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        
        return router
    }
    
    func presentDiscover(with name: String, from view : UIViewController) {
        
        let discoverRouter = DiscoverGenreRouter.start(with: name)
        
        print("presenting new view...")
        let newView = discoverRouter.entryView!
       
        view.navigationController?.pushViewController(newView, animated: true)
    
    }
    
}
