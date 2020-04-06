//
//  MovieNetworkManger.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

class MovieNetworkManger:NetworkManger {
    
    typealias responseHandler = (Result<BaseModel<MovieModel>,ApiError>)->Void

    func discoverMovie(by page:Int = 1,completion:@escaping responseHandler)  {
        
        let movieRouter = MovieRouter(endPoint: .discoverMovie(page: page))
        
        self.performNetworRequest(movieRouter) { (result) in
           completion(result)
        }
        
    }
    
    func searchMovie(by page:Int = 1,query:String,completion:@escaping responseHandler)  {
        
        let movieRouter = MovieRouter(endPoint: .searchMovies(page: page, query: query))
        
        self.performNetworRequest(movieRouter) { (result) in
            completion(result)
        }
        
    }
}
