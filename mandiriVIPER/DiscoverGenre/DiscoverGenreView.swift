//
//  DIscoverGenreView.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import UIKit

protocol DiscoverGenreViewProtocol {
    var presenter : DiscoverGenrePresenterProtocol? { get set}
    func updateMovieList(with results : MovieResult, images: [UIImage])
}

class DiscoverGenreView: UIViewController, DiscoverGenreViewProtocol {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var movieList : [Movie] = []
    var imageList : [UIImage] = []
    var presenter: DiscoverGenrePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectionView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCell")
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    func updateMovieList(with results : MovieResult, images : [UIImage]) {
        DispatchQueue.main.async {
            for i in results.results{
                self.movieList.append(i)
            }
            for i in images{
                self.imageList.append(i)
            }
            self.moviesCollectionView.reloadData()
            print("reloading movie collection")
            print("image count : \(self.imageList.count)")
            print("movie count : \(self.movieList.count)")
        }
    }

}
extension DiscoverGenreView : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        cell.cellTitle.text = movieList[indexPath.row].original_title
        DispatchQueue.main.async {
            if self.imageList.count > 0{
                cell.cellImage.image = self.imageList[indexPath.row]
            }
            cell.
            
        }
        return cell
    }
    
    
    
    
}
