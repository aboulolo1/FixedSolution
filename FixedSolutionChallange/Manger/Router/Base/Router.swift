//
//  Router.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation

enum HttpMethod : String {
    case get = "Get"
    case post = "Post"
}

typealias httpHeaders = [String:String]
typealias httpParameters = [String:String]

protocol Router {
    var path:String{get}
    var baseUrl:String{get}
    var scheme:String{get}
    var method:HttpMethod { get }
    var headers:httpHeaders? { get }
    var baseParameter:httpParameters? { get}
    var parameter:httpParameters? { get}
    var body:httpParameters? { get }
}
extension Router{
    var headers:httpHeaders?{
        return ["content-type":"application/json","Accept":"application/json"]
    }
    var baseParameter:httpParameters?{
        get{
            return ["api_key":"47cd13548fd27bb3d1b4d9a59c3bb745","language":"en-US"]
        }
    }
    var baseUrl:String{
        return "api.themoviedb.org"
    }
    
    var body:httpParameters?{
        return nil
    }
    
    var scheme:String{
           return "https"
       }
}
