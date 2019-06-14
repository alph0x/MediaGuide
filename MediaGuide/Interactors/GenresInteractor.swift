//
//  GenresInteractor.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import Siesta
import RxSwift

class GenresInteractor {

    let moviesGenresObservable:PublishSubject<[Genre]>
    let tvshowsGenresObservable:PublishSubject<[Genre]>
    
    var moviesGenresResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var tvshowsGenresResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    init() {
        moviesGenresObservable = PublishSubject()
        tvshowsGenresObservable = PublishSubject()
    }
    
    func movies() {
        moviesGenresResource = api.genresResource!.movieGenres()
        moviesGenresResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Genre] = resource.typedContent() else { return }
                self.moviesGenresObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
    
    func tvshow() {
        tvshowsGenresResource = api.genresResource!.tvGenres()
        tvshowsGenresResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Genre] = resource.typedContent() else { return }
                self.tvshowsGenresObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
}
