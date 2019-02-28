//
//  MoviesViewController.swift
//  Flix
//
//  Created by stargaze on 2/21/19.
//  Copyright © 2019 blinkous. All rights reserved.
//

import UIKit
import AlamofireImage

//To Use table view, add in: UITableViewDataSource, UITableViewDelegate
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    Variables created here are called properties
    @IBOutlet weak var tableView: UITableView!
    
    //    Create an array of dictionaries: key type of string and value type of any
    //    [array] -> [[dictionary]] -> [[key type: value type]] ; () -> inidicate creation of something
    var movies = [[String:Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                
                // Reload the table data so that movies count is not 0 and will not show blank rows
                // Allows the other 2 tableview functions to be called again and again to load the names
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    //    Asking for a number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    //  for this row, what is the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell = UITableViewCell()
        // using dequeue method allows you recycle cells that are off-screen and here we use our custom MovieCell that we designed
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        // To print out movie title on the row, we need to first get the movie titles
        let movie = movies[indexPath.row]
        // We grab the value associated with the key "title" in the API dictionary and cast it as string
        let title = movie["title"] as! String

        // cell.textLabel!.text = title // our custom cell title is titleLabel
        cell.titleLabel.text = title
        //Displays a string with the text row and the row number
        //cell.textLabel!.text = "row: \(indexPath.row)" //  Adding a backslash and a set of parenthesis allows you to insert variables into the string
        
        // Set the synopsis
        let synopsis = movie["overview"] as! String
        cell.synopsisLabel.text = synopsis
        
        // Get the poster image
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        // URL has some form of validation to make sure that this is a URL
        let posterUrl = URL(string: baseUrl + posterPath)
        
        // Using the pod library AlamofireImage allows us to use this to get an image from a URL and the pod will take care of downloading and getting it
        cell.posterView.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //sender is the cell that was tapped on, it's of the default type Any?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up the details screen")
        
        // Find the selected movie
        let cell = sender as! UITableViewCell // cast the sender as the UITableViewCell
        let indexPath = tableView.indexPath(for: cell)! // tableview knows for a given cell what the index path is
        let movie = movies[indexPath.row] // finally access the array
        
        // Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController //must cast as a MoviesDetailsViewController or else it'll be a generic view controller without the movie variable in that controller
        detailsViewController.movie = movie // set the movie property of the MovieDetailsViewContoller as this movie that has been selected
        tableView.deselectRow(at: indexPath, animated: true) // deselect the row so that it's only highlighted briefly when you select it.
    }
    
}
