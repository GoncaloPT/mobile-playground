//
//  SearchViewController.swift
//  movieliststoryboard
//
//  Created by ctw00977-admin on 16/09/2020.
//  Copyright © 2020 ctw00977-admin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet var tableView: UITableView!
    var searchResults: [Movie] = []
    weak var delegate: ViewController!
    
    
    @IBAction func search (sender: UIButton){
        print("searching....")
        var searchTearm = searchText.text!
        if searchTearm.count > 2{
            retrieveMoviesByTerm(term: searchTearm)
        }
        
    }
    @IBAction func addFavorite(sender: UIButton){
        print("selected #\(sender.tag) was selected as favorite")
        self.delegate.favoriteMovies.append(searchResults[sender.tag])
    }
    func retrieveMoviesByTerm(term: String){
        let url = "https://www.omdbapi.com/?s=\(term)&type=movie&r=json&apikey=f4cb0232"
        MovieService.getJson(urlString: url, completionHandler: parseDataIntoMovies)
        
    }
    func parseDataIntoMovies(data: Data?) -> Void{
        if let data = data{
            let object = MovieService.parseJson(data: data)
            if let object = object {
                self.searchResults = MovieService.mapJsonToMovies(object: object, moviesKey: "Search")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search Results"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as! CustomTableViewCell
        let index: Int = indexPath.row
        moviecell.favButton.tag = index
        
        moviecell.movieTitleLabel?.text = searchResults[index].title
        moviecell.movieYearLabel?.text = searchResults[index].year
        displayMovieImage(index, moviecell: moviecell)
        return moviecell;
    }
    
    func displayMovieImage(_ row: Int, moviecell: CustomTableViewCell) {
        let url: String = (URL(string: searchResults[row].imageUrl)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                let image = UIImage(data: data!)
                moviecell.movieImageView?.image = image
            })
        }).resume()
    }
    
}
