//
//  HomeScreenViewController.swift
//  Concrete iOS Recruit Challenge
//
//  Created by Fagner Caetano on 10/08/20.
//

import UIKit
import AFNetworking

class HomeScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    var movies: [NSDictionary]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Connection().fetchMovies(completion: didFetchMovies)

    }
    
    func didFetchMovies(movies: [NSDictionary]?) {
        self.movies = movies
        self.moviesCollection.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let movieCount = movies else { return 0 }
        return movieCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MoviesCollectionViewCell
        let movieInfo = movies![indexPath.row] as NSDictionary
        let title = movieInfo["title"] as! String
        let posterPath = movieInfo["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let imageURL = URL(string: baseURL + posterPath)
        movieCell.titleTextLabel.text = title
        movieCell.movieImageView.setImageWith(imageURL!)
        movieCell.favoriteButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        return movieCell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
