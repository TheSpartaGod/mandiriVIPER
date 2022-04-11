//
//  DIscoverGenreView.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import UIKit

protocol DiscoverGenreViewProtocol {
    var presenter : DiscoverGenrePresenterProtocol? { get set}
    func updateMovieList()
    var movieList : [Movie]? {get set}
    var imageList : [UIImage]? {get set}
}

class DiscoverGenreView: UIViewController, DiscoverGenreViewProtocol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var movieList : [Movie]? = []
    var imageList : [UIImage]? = []
    var presenter: DiscoverGenrePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectionView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCell")
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
    }
    
    func updateMovieList() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
        
    }
    
}
extension DiscoverGenreView : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.cellTitle.text = movieList?[indexPath.row].original_title
        cell.cellImage.image = self.imageList?[indexPath.row]
        cell.cellImage.contentMode = .scaleToFill
        cell.cellImage.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectMovie(movie: (movieList?[indexPath.row])!)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //load more movies if list nears its end.
        if(indexPath.row == (self.movieList?.count ?? 0)-1 && !(self.movieList?.isEmpty ?? true)){
            
            
        }
    }
    
}
extension DiscoverGenreView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size:CGFloat = (moviesCollectionView.frame.size.width) / 3 //this doesn't work somehow...
        return CGSize(width: size, height: 100)
    }
    
    
}
