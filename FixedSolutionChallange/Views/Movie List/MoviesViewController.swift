//
//  MoviewsViewController.swift
//  FixedSolutionChallange
//
//  Created by Alaa on 4/5/20.
//  Copyright © 2020 FixedSolution. All rights reserved.
//

import UIKit
import SearchTextField
import RxSwift

class MoviesViewController: BaseViewController {
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var searchTextField: SearchTextField!
    var viewModel:MoviesViewModel?
    override var baseViewModel: BaseViewModel?{
        didSet{
            viewModel = baseViewModel as? MoviesViewModel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewModel = MoviesViewModel()
        configureUI()
        configureBindings()
        viewModel?.getLatestMovies(with: .Default)
    }
    override func configureBindings() {
        super.configureBindings()
        guard let viewModel = viewModel else{return}

        viewModel.dataSource.bind(to: movieCollectionView.rx.items(cellIdentifier: "movieCell", cellType: MovieCollectionViewCell.self)) { [weak self](row, element, cell) in
            if let cellViewModel = self?.viewModel?.dataSource.value[row]{
                cell.cellViewModel = cellViewModel
            }
        }.disposed(by: viewModel.bag)
        
        movieCollectionView.rx.itemSelected.subscribe(onNext:{ [weak self] indexPath in
            if let cellViewModel = self?.viewModel?.dataSource.value[indexPath.row]{
                self?.viewModel?.pushViewControllerSubject.onNext(MovieDetailViewModel(movieCellViewModel: cellViewModel))
            }

            }).disposed(by: viewModel.bag)

        viewModel.textFieldItemsSubject.observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (searchItems) in
                guard let self = self else {return}
                self.searchTextField.stopLoadingIndicator()
                self.searchTextField.filterItems(searchItems)

            })
         .disposed(by: viewModel.bag)
        
        searchTextField.itemSelectionHandler = {[weak self] item, itemPosition in
            guard let self = self else {return}
            if let cellViewModel = self.viewModel?.searchDataSource[itemPosition]{
                self.viewModel?.pushViewControllerSubject.onNext(MovieDetailViewModel(movieCellViewModel: cellViewModel))
                self.searchTextField.resignFirstResponder()
            }
        }

        searchTextField.userStoppedTypingHandler = {[weak self] in
            guard let self = self else {return}
            if let criteria = self.searchTextField.text {
                if criteria.count % 3 == 0{
                    self.searchTextField.showLoadingIndicator()
                    viewModel.searchMovie(with: criteria)
                }
            }
        }
    }
   
    private func configureUI(){
           movieCollectionView.infiniteScrollIndicatorStyle = .white
           movieCollectionView.addInfiniteScroll { (collectionView) -> Void in
               collectionView.performBatchUpdates({ [weak self]() -> Void in
                self?.viewModel?.getLatestMovies(with: .InfiniteScroll)
               }, completion: { (finished) -> Void in
                   // finish infinite scroll animations
                   collectionView.finishInfiniteScroll()
               });
           }
           let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: CollectionViewItem.spacing, left: CollectionViewItem.spacing, bottom: CollectionViewItem.spacing, right: CollectionViewItem.spacing)
           layout.itemSize = CGSize(width: CollectionViewItem.width, height: CollectionViewItem.height)
           layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
           movieCollectionView!.collectionViewLayout = layout
    
        searchTextField.delegate = self
        searchTextField.theme = SearchTextFieldTheme.darkTheme()
        searchTextField.theme.font = UIFont.systemFont(ofSize: 12)
        searchTextField.theme.bgColor = .black


    }
       

}
extension MoviesViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
