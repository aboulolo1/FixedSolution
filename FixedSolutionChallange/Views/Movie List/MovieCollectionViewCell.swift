//
//  MovieCollectionViewCell.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import UIKit
import SDWebImage
class MovieCollectionViewCell: UICollectionViewCell {
    
    var cellViewModel:MovieCellViewModel!{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    func updateView() {
        movieName.text = cellViewModel.name
        movieImage.sd_setImage(with: URL(string: cellViewModel.posterImage), completed: nil)
        
    }
}
