//
//  MoviesViewController.swift
//  MoviesInfo
//
//  Created by Mac-mini 2 on 02/06/22.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var url1 = "https://api.themoviedb.org/3/movie/upcoming?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=en-US&page=1"
    var moviesList = [Result]()
    var imagesArray = [UIImage]()
    var filteredArray = [Result]()
    var emptyArray = NSMutableArray()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        getListOfMovies()
    }
    
    func getListOfMovies(){
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url1)!)){(data,req,error) in
            do{
                let result = try JSONDecoder().decode(MoviesData.self, from: data!)
                DispatchQueue.main.async {
                    self.moviesList = result.results
                    self.filteredArray = self.moviesList
                    for i in 0...((self.moviesList).count - 1){
                        self.getImagesOfMovies(data: self.moviesList[i])
                    }
                    self.moviesTableView.reloadData()
                }
            }catch{
                
            }
        }.resume()
    }
    
    func getImagesOfMovies(data: Result){
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.backdropPath)")!)){(data,req,error) in
                    do{
                        let image =  data
                        DispatchQueue.main.async {
                            self.imagesArray.append(UIImage(data: image!)!)
                            self.moviesTableView.reloadData()
                            //self.moviesImageView.image = UIImage(data: image!)!
                        }
                    }catch{
                        print("Error")
                    }
                }.resume()
    }
    
    func NavigateToMovieDetailsScreen(moviesObject: [Result],image:UIImage){
        DispatchQueue.main.async {
            let movieDetailsScreen = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsView") as? MovieDetailsViewController
            movieDetailsScreen?.data = "data"
            movieDetailsScreen?.DataArray = moviesObject
            movieDetailsScreen?.image = image
            self.navigationController?.pushViewController(movieDetailsScreen!, animated: true)
           
        }
    }
}



extension MoviesViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesView") as? moviesTableViewCell
        cell?.lblMovieName.text = filteredArray[indexPath.row].title
        cell?.lblMovieRating.text = String(filteredArray[indexPath.row].popularity)
        if imagesArray.count > 0{
        cell?.moviesImageView.image = imagesArray[indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NavigateToMovieDetailsScreen(moviesObject: [filteredArray[indexPath.row]], image: imagesArray[indexPath.row])
    }
    
    
}

extension MoviesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if searchText == ""{
        filteredArray = self.moviesList
    }else{
        for movies in moviesList{
            if  movies.title.uppercased().contains((searchText.uppercased())){
                filteredArray.append(movies)
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            }
        }
    }
    }

    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""

        searchBar.showsCancelButton = false
    }
}
