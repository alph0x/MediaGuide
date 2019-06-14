//
//  MoviesListPresenter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import RxSwift

class MoviesListPresenter {
    
    private let interactor = MoviesListInteractor()
    private let disposeBag = DisposeBag()
    
    var updateHandler:((UITableViewCell) -> Void)?
    
    init(with tableView: UITableView) {
        let detailedMedia = DetailedMediaListViewModel()
        let highlightedMedia = HighlightedMediaListViewModel()
        interactor.nowPlayingObservable.subscribe { (movies) in
            self.updateHandler!(highlightedMedia.instanceList(with: movies.element!, on: tableView))
            }.disposed(by: self.disposeBag)
        interactor.popularObservable.subscribe { (movies) in
            self.updateHandler!(detailedMedia.instanceList(with: movies.element!, on: tableView))
            }.disposed(by: self.disposeBag)
        let defaultMedia = DefaultMediaListViewModel()
        interactor.topRatedObservable.subscribe { (movies) in
            self.updateHandler!(defaultMedia.instanceList(with: "Top rated", and: movies.element!, on: tableView))
            }.disposed(by: self.disposeBag)
        interactor.upcomingObservable.subscribe { (movies) in
            self.updateHandler!(defaultMedia.instanceList(with: "Upcoming", and: movies.element!, on: tableView))
            }.disposed(by: self.disposeBag)
    }
    
    func nowPlaying(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.nowPlaying()
    }
    
    func popular(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.popular()
    }
    
    func topRated(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.topRated()
    }
    
    func upcoming(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.upcoming()
    }
    
    func dataSource(updateHandler: @escaping (([UITableViewCell]) -> Void)) {
        self.nowPlaying { (nowPlayingCell) in
            self.popular { (popularCell) in
                self.topRated { (topRatedCell) in
                    self.upcoming { (upcomingCell) in
                        updateHandler([nowPlayingCell, popularCell, topRatedCell, upcomingCell])
                    }
                }
            }
        }
    }
}
