import UIKit

var str = "Hello, playground"

str += " Gonçalo is here"

var string2 = "Outro"

string2 = "outro2"

// swift; ? = optional
class Movie{
    var title: String!
    var category: String?
    init(title: String!){
        self.title = title
    }
    
    
    // -> is the return type
    func getMovieTitle() -> String{
        return title;
    }
    func getCategory() -> String{
        if let category = category{
            return category;
        }
        return "general";
    }
    
}

var movie = Movie(title: "as");
print("This is the movie title: \(movie.getMovieTitle())")
