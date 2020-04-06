//
//  MovieCellViewModel.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation
struct MovieCellViewModel {
    
    var movieModel:MovieModel
    
    var name:String{
        return movieModel.title ?? ""
    }
    var posterImage:String{
        return image_url_path + (movieModel.posterPath ?? "")
    }
    var id:Int{
        return movieModel.id!
    }
    var overView:String{
        return movieModel.overview ?? ""
    }
    var releaseDate:String{
        return movieModel.releaseDate ?? ""
    }
    init(movieModel:MovieModel) {
        self.movieModel = movieModel
    }

}
