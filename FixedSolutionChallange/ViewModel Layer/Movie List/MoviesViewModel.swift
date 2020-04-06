//
//  MoviesViewModel.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SearchTextField

class MoviesViewModel:BaseViewModel {
    
    private let networkManger = MovieNetworkManger()
    var curentPage = 1
    var totalPages = 1
    var dataSource = BehaviorRelay<[MovieCellViewModel]>(value: [])
    var textFieldItemsSubject = PublishSubject<[SearchTextFieldItem]>()
    
    var searchDataSource:[MovieCellViewModel] = []

    func getLatestMovies(with loadingType:LoadingType = .Default)  {
        
        if curentPage > totalPages{
            return
        }
        self.showLoadingSubject.onNext(loadingType)
        
        networkManger.discoverMovie(by: curentPage) { [weak self](result) in
            guard let self = self else{return}
            self.hideLoadingSubject.onNext(loadingType)
            switch result{
            case .success(let model):
                self.totalPages = model.totalPages ?? 1
                self.configureDataSource(model.results)
            case .failure(let error):
                self.showAlertErrorSubject.onNext(error.localizedDescritpion)
            }
        }
    }

    func searchMovie(with query:String)  {
        networkManger.searchMovie(query: query){ [weak self](result) in
            guard let self = self else{return}
            switch result{
            case .success(let model):
                if let movieList = model.results{
                    self.configureSearchDataSource(movieList)
                }
            case .failure(let error):
                self.showAlertErrorSubject.onNext(error.localizedDescritpion)
            }
        }
    }
    
    func configureSearchDataSource(_ movieList:[MovieModel])  {
        let movieCellViewModelArray = movieList.map{MovieCellViewModel(movieModel: $0)}
        searchDataSource.append(contentsOf: movieCellViewModelArray)
        textFieldItemsSubject.onNext(searchDataSource.map{SearchTextFieldItem(title: $0.name)})
    }
    
     func configureDataSource(_ movieList:[MovieModel]?){
        guard let movieList = movieList , movieList.count > 0 else {
            self.showAlertErrorSubject.onNext("No Data Found")
            return
        }
        
        let movieCellViewModelArray = movieList.map{MovieCellViewModel(movieModel: $0)}
        dataSource.accept(dataSource.value + movieCellViewModelArray)
        curentPage += 1
    }

    
}
