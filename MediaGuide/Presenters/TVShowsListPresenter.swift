//
//  TVShowsListPresenter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TVShowsListPresenter {
    
    let interactor = TVShowsListInteractor()
    private let disposeBag = DisposeBag()
    
    var updateHandler:((UITableViewCell) -> Void)
    
    init(with tableView:UITableView) {
        updateHandler = { (cells) in }
        let highlightedMedia = HighlightedMediaListViewModel()
        self.interactor.airingTodayObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(highlightedMedia.instanceList(with: elements, on: tableView))
            }.disposed(by: disposeBag)
        let detailedMedia = DetailedMediaListViewModel()
        self.interactor.popularObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(detailedMedia.instanceList(with: elements, on: tableView))
            }.disposed(by: disposeBag)
        let defaultMedia = DefaultMediaListViewModel()
        self.interactor.topRatedObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(defaultMedia.instanceList(with: "Top rated", and: elements, on: tableView))
            }.disposed(by: disposeBag)
        self.interactor.onTheAirObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(defaultMedia.instanceList(with: "Top rated", and: elements, on: tableView))
            }.disposed(by: disposeBag)
    }
    
    func airingToday(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.airingToday()
    }
    
    func popular(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.popular()
    }
    
    func topRated(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.topRated()
    }
    
    func onTheAir(with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.updateHandler = updateHandler
        interactor.onTheAir()
    }
    
    func dataSource(updateHandler: @escaping (([UITableViewCell]) -> Void)) {

        self.airingToday { (airingTodayCell) in
            self.popular { (popularCell) in
                self.topRated { (topRatedCell) in
                    self.onTheAir { (onTheAirCell) in
                        updateHandler([airingTodayCell, popularCell, topRatedCell, onTheAirCell])
                    }
                }
            }
        }
    }
    
}
