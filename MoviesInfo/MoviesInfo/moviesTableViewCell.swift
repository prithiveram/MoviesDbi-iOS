//
//  moviesTableViewCell.swift
//  MoviesInfo
//
//  Created by Mac-mini 2 on 02/06/22.
//

import UIKit

class moviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviesImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataToControls(data: Result){
        self.lblMovieName.text = data.title
        self.lblMovieRating.text = String(data.popularity)
//        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.backdropPath)")!)){(data,req,error) in
//            do{
//                let image =  data
//                DispatchQueue.main.async {
//                    self.moviesImageView.image = UIImage(data: image!)!
//                }
//            }catch{
//                print("Error")
//            }
//        }.resume()
    }

}
