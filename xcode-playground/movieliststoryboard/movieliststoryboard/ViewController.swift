//
//  ViewController.swift
//  movieliststoryboard
//
//  Created by ctw00977-admin on 16/09/2020.
//  Copyright © 2020 ctw00977-admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchMoviesSegue"{
            let controller = segue.destination as! SearchViewController
            controller.delegate = self;
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moviecell = tableView.dequeueReusableCell(withIdentifier: "moviecell", for: indexPath) as! CustomTableViewCell
        let index: Int = indexPath.row
        
        moviecell.movieTitleLabel?.text = favoriteMovies[index].title
        moviecell.movieYearLabel?.text = favoriteMovies[index].year
        //displayMovieImage(moviecell.movieImageView , favoriteMovies[index].imageUrl)
        return moviecell;
    }
    
    func displayMovieImage( imageView: UIImageView, imageUrl: String){
        URLSession.shared.dataTask(with: URL(string: imageUrl)! , completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data!)
                imageView.image = image
            }
            }).resume()
        
    }
    var favoriteMovies: [Movie] = []
    @IBOutlet var mainTableView: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        mainTableView.reloadData()
        if favoriteMovies.count == 0 {
            favoriteMovies.append(Movie(id:"1",title: "Movie1 title", year:"2005",imageUrl: ""))
            favoriteMovies.append(Movie(id:"1",title: "Movie2 title", year:"2005",imageUrl: ""))
            favoriteMovies.append(Movie(id:"1",title: "Movie3 title", year:"2005",imageUrl: ""))
        }
        
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

