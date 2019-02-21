//
//  MoviesViewController.swift
//  Flix
//
//  Created by stargaze on 2/21/19.
//  Copyright © 2019 blinkous. All rights reserved.
//

import UIKit

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
        // using dequeue method allows you to use your custom MovieCell that we designed
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
        let baseUrl = "https://image.tmbd.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        // URL has some form of validation to make sure that this is a URL
        let posterUrl = URL(string: baseUrl + posterPath)
        
        
        
        return cell
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
