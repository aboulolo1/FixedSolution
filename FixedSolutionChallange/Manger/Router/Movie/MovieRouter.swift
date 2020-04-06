//
//  MovieRouter.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

enum MovieEndPoint {
    case searchMovies(page:Int,query:String)
    case discoverMovie(page:Int)
}
struct MovieRouter:Router {
    
    var endPoint:MovieEndPoint
    var path: String{
        switch endPoint {
        case .searchMovies:
            return "/3/search/movie"
        case .discoverMovie:
            return "/3/movie/now_playing"
        }
    }
    
    var method: HttpMethod{
        switch endPoint {
              case .searchMovies,.discoverMovie:
                return .get
            
              }
    }
    var parameter: httpParameters?{
        switch endPoint {
        case .searchMovies(let page,let query):
            var mutableParamter = baseParameter
            mutableParamter?["page"] = "\(page)"
            mutableParamter?["query"] = query
            return mutableParamter
        case .discoverMovie(let page):
            var mutableParamter = baseParameter
            mutableParamter?["page"] = "\(page)"
            return mutableParamter

        }
    }
   
    
}
