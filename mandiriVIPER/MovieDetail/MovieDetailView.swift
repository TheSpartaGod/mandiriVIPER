//
//  MovieDetailView.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import UIKit
import WebKit
protocol MovieDetailViewProtocol {
    var presenter : MovieDetailPresenterProtocol? {get set}
    var movieInfo : MovieDetail? {get set}
    var posterImage : UIImage? {get set}
    var trailerLink : String? {get set}
    var reviews : [Review]? {get set}
    var reviewPageCount : Int? {get set}
    func updateAllViews()
    
}
class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    var movieInfo: MovieDetail?
    var trailerLink: String?
    var posterImage: UIImage?
    var reviews: [Review]?
    var reviewPageCount : Int? = 0
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var videoBackground: UIView!
    @IBOutlet weak var trailerTitle: UILabel!
    @IBOutlet weak var yearRelease: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        
        
    }
    
    func updateAllViews() {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = self.movieInfo!.original_title
            self.trailerTitle.text = "Trailer for \(self.movieInfo!.original_title)"
            self.posterImageView.image = self.posterImage
            var webView: WKWebView?
            let webViewConfig = WKWebViewConfiguration()
            
            webViewConfig.allowsInlineMediaPlayback = false
            webView = WKWebView(frame: self.videoBackground.frame, configuration: webViewConfig)
            
            let myURL = URL(string: "https://www.youtube.com/embed/\(self.trailerLink ?? "default")?playsinline=1?autoplay=1")
            let youtubeRequest = URLRequest(url: myURL!)
            
            webView!.load(youtubeRequest)
            guard let finalWebView = webView else{ return}
            finalWebView.frame = self.videoBackground.bounds
            self.videoBackground.addSubview(finalWebView)
            self.reviewTableView.reloadData()
        }
        
    }
    
}
extension MovieDetailView : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.reviewNameLabel.text = reviews?[indexPath.row].author
        cell.reviewContentLabel.text = reviews?[indexPath.row].content
        
        return cell
    }
    
    
    
    
}
