//
//  MediaDetailPresenter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import RxSwift

class MediaDetailPresenter {
    
    let interactor = MediaDetailInteractor()
    var viewModel:MediaDetailViewModel
    
    private let disposeBag = DisposeBag()
    
    var detailsHandler:((Media) -> Void)
    var creditsHandler:(([UITableViewCell]) -> Void)
    var videosHandler:((UITableViewCell) -> Void)
    
    init() {
        viewModel = MediaDetailViewModel()
        detailsHandler = { (media) in }
        creditsHandler = { (credits) in }
        videosHandler = { (videos) in}
    }
    
    convenience init(with tableView: UITableView) {
        self.init()
        interactor.detailsObservable.subscribe { (media) in
            guard let elements = media.element else { return }
            self.detailsHandler(elements)
            }.disposed(by: disposeBag)
        
        viewModel = MediaDetailViewModel(with: tableView)
        interactor.creditsObservable.subscribe { (credits) in
            guard let elements = credits.element else { return }
            var cells:[UITableViewCell] = []
            cells.append(self.viewModel.creditsTableViewCell(for: elements.crew))
            cells.append(self.viewModel.creditsTableViewCell(for: elements.cast))
            self.creditsHandler(cells)
        }.disposed(by: disposeBag)
        interactor.videosObservable.subscribe { (videos) in
            guard let elements = videos.element else { return }
            if elements.count == 0 {
                self.videosHandler(UITableViewCell())
                return
            }
            self.videosHandler(self.viewModel.relatedVideosTableViewCell(for: elements))
        }.disposed(by: disposeBag)
    }
    
    func details(for media:Media, with handler: @escaping ((Media) -> Void)) {
        self.detailsHandler = handler
        interactor.details(for: media)
    }
    
    func overview(for media:Media, with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        updateHandler(viewModel.overviewTableViewCell(for: media))
    }
    
    func summary(for media:Media, with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        updateHandler(viewModel.summaryTableViewCell(for: media))
    }
    
    func credits(for media:Media, with updateHandler:@escaping (([UITableViewCell]) -> Void)) {
        self.creditsHandler = updateHandler
        interactor.credits(for: media)
        
    }
    
    func relatedVideos(for media:Media, with updateHandler:@escaping ((UITableViewCell) -> Void)) {
        self.videosHandler = updateHandler
        interactor.videos(for: media)
    }
    
    func dataSource(for media:Media, with updateHandler: @escaping (([UITableViewCell]) -> Void)) {
        self.overview(for: media) { (overviewCell) in
            self.summary(for: media) { (summaryCell) in
                self.relatedVideos(for: media) { (videosCell) in
                    updateHandler([overviewCell, summaryCell, videosCell])
                }
                updateHandler([overviewCell, summaryCell])
            }
            updateHandler([overviewCell])
        }
    }
}
