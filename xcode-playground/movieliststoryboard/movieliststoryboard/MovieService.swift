//
//  MovieService.swift
//  movieliststoryboard
//
//  Created by ctw00977-admin on 17/09/2020.
//  Copyright © 2020 ctw00977-admin. All rights reserved.
//

import Foundation

class MovieService{
    
    static func getJson(urlString: String, completionHandler: @escaping (Data?) ->
        (Void)){
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .
            urlQueryAllowed)
        let url = URL(string: urlString!)
        print("URL being used is \(url!)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!){ data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("request completed with code: \(statusCode)")
                if(statusCode == 200){
                    print("data found")
                    completionHandler(data as Data)
                }
                
            }
            else if let error = error{
                print("ERROR in http request")
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
        task.resume()
    }
    
    static func parseJson(data: Data ) -> [String: AnyObject]?{
        let options = JSONSerialization.ReadingOptions()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: options) as? [String: AnyObject]
            return json!
        }
        catch(let parseError){
            print("There was an error parsing: \(parseError.localizedDescription)")
        }
        return nil;
    }
    
    static func mapJsonToMovies(object: [String: AnyObject], moviesKey: String)-> [Movie]{
        var mappedMovies: [Movie] = []
        guard let movies = object[moviesKey] as? [[String: AnyObject]] else{
            return mappedMovies
        }
        for movie in movies{
            guard let id = movie["imdbID"] as? String,
                let name = movie["Title"] as? String,
                let year = movie["Year"] as? String,
                let imageUrl = movie["Poster"] as? String else {continue}
            
            let movieInstance = Movie(id:id, title:name, year:year, imageUrl: imageUrl)
            mappedMovies.append(movieInstance)
        }
        return mappedMovies
    }
}
