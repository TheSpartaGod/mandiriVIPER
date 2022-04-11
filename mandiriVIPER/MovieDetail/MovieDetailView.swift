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
    var reviewCount : Int? {get set}
    func updateAllViews()
    func appendReview()
    
}
class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    var movieInfo: MovieDetail?
    var trailerLink: String?
    var posterImage: UIImage?
    var reviews: [Review]?
    var reviewCount : Int? = 0
    var page : Int = 1
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var videoBackground: UIView!
    @IBOutlet weak var trailerTitle: UILabel!
    @IBOutlet weak var yearRelease: UILabel!
    @IBOutlet weak var overviewTextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.dataSource = self
        reviewTableView.delegate = self
        reviewTableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
    }
    override func viewWillDisappear(_ animated: Bool) {
        
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
            self.reviewCount = self.reviews?.count
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let releaseDate = formatter.date(from: self.movieInfo?.release_date ?? "")
            formatter.dateFormat = "yyyy"
            let yearString = formatter.string(from: releaseDate ?? Date())
            self.yearRelease.text = yearString
            self.overviewTextBox.text = self.movieInfo?.overview
        }
        
    }
    func appendReview(){
        DispatchQueue.main.async {
            
            if (self.reviewCount ?? 0 > self.reviews?.count ?? 0){ //check if there are new reviews
                self.reviewCount = self.reviews?.count
                self.reviewTableView.insertRows(at: [IndexPath(row: self.reviewCount ?? 0, section: 0)], with: .fade)
            }
            
            print("appended something to the review box")
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == (reviews?.count ?? 0)-1 && reviews?.count ?? 0 > 0){
            page += 1
            presenter?.getMoreReviews(id: movieInfo?.id ?? 0, page: self.page)
            
        }
    }
}
