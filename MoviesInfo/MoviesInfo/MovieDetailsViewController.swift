//
//  MovieDetailsViewController.swift
//  MoviesInfo
//
//  Created by Mac-mini 2 on 04/06/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblReleaseDate1: UILabel!
    @IBOutlet weak var lblReleaseDate2: UILabel!
    @IBOutlet weak var lblLanguages1: UILabel!
    @IBOutlet weak var lblLanguages2: UILabel!
    @IBOutlet weak var lblAbout1: UILabel!
    @IBOutlet weak var lblAbout2: UILabel!
    
    var data = ""
    var DataArray = [Result]()
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayDetails()
        // Do any additional setup after loading the view.
    }

    func displayDetails(){
        lblMovieName.text = DataArray[0].title
        lblReleaseDate1.text = "Release Date: "
        lblReleaseDate2.text = DataArray[0].releaseDate
        lblLanguages1.text = "Language: "
        lblLanguages2.text = DataArray[0].originalLanguage.rawValue
        lblAbout1.text = "OverView: "
        lblAbout2.text = DataArray[0].overview
        movieImageView.image = self.image
        
    }

}
