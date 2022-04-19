//
//  ViewController.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 08/04/22.
//

import UIKit

protocol GenreListViewProtocol {
    var presenter : GenrePresenterProtocol? {get set}
    var viewController : GenreListView? {get set}
    func update(with genres: [Genre])
}
class GenreListView: UIViewController , GenreListViewProtocol{


    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var emptyGenreLabel: UITextView!
    @IBOutlet weak var emptyGenreLoading: UIActivityIndicatorView!
    
    var genreList : [Genre] = []
    var presenter: GenrePresenterProtocol?
    var viewController: GenreListView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("bruh moment")
        viewController = self
        genreTableView.register(UINib(nibName: "GenreCell", bundle: nil), forCellReuseIdentifier:"GenreCell")
        genreTableView.delegate = self
        genreTableView.dataSource = self
               
    }
    
    func update(with genres: [Genre]) {
        print("reloaded data")
        DispatchQueue.main.async {
            self.genreList = genres
            self.genreTableView.reloadData()
            self.genreTableView.isHidden = false
            self.emptyGenreLoading.isHidden = true
            self.emptyGenreLabel.isHidden = true
            
        }
    }

}
extension GenreListView : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = genreTableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        cell.genreNameLabel.text = genreList[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("genre id : \(genreList[indexPath.row].id)")
        self.presenter?.didSelectGenre(genreName: String(genreList[indexPath.row].id), from: self)
        
    }
    
    
}

