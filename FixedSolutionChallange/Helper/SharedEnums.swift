//
//  SharedENUMS.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//
import UIKit

enum LoadingType: Int {
    case Default = 1
    case Search = 2
    case InfiniteScroll = 3
}
enum CollectionViewItem {
    static let width = Int(UIScreen.main.bounds.width/3) - 20
    static let height = 350
    static let spacing:CGFloat = 10.0    
}

let image_url_path = "https://image.tmdb.org/t/p/w500"
