//
//  MovieGridViewController.swift
//  Flix
//
//  Created by stargaze on 2/28/19.
//  Copyright © 2019 blinkous. All rights reserved.
//

import UIKit
import AlamofireImage

// Add UICollectionViewDataSource, UICollectionViewDelegate for collection view
class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Changing the layout configuration
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 4 // Control the spacing between the rows
        layout.minimumInteritemSpacing = 4 // Set spacing btw columns
        
        // To set the collection view cell size
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3 // set width to the width of the screen divided by 3
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                // Cast as! an array of dictionaries
                self.movies = dataDictionary["results"] as! [[String:Any]]
                
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        // Get the poster image and set it
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //sender is the cell that was tapped on, it's of the default type Any?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected movie
        let cell = sender as! UICollectionViewCell // cast the sender as the UITableViewCell
        let indexPath = collectionView.indexPath(for: cell)! // tableview knows for a given cell what the index path is
        let movie = movies[indexPath.row] // finally access the array
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController //must cast as a MoviesDetailsViewController or else it'll be a generic view controller without the movie variable in that controller
        detailsViewController.movie = movie // set the movie property of the MovieDetailsViewContoller as this movie that has been selected
    }

}
