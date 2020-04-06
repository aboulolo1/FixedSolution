//
//  MovieDetailViewModel.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/6/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

class MovieDetailViewModel:BaseViewModel {

    override var viewIdentifier: ViewIdentifier!{
        get{
            return ViewIdentifier(storyboardIdentifier: "Main", ViewControllerIdentifier: "MovieDetailViewController")
        }
        set{}
    }
    var movieCellViewModel:MovieCellViewModel
    init(movieCellViewModel:MovieCellViewModel) {
        self.movieCellViewModel = movieCellViewModel
    }
}
