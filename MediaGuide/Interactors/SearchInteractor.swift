//
//  SearchInteractor.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import RxSwift

class SearchInteractor {
    
    let moviesSearchObservable:PublishSubject<[Movie]>
    let moviesGenresObservable:PublishSubject<[Movie]>
    let tvshowsSearchObservable:PublishSubject<[TVShow]>
    let tvshowsGenresObservable:PublishSubject<[TVShow]>
    
    var moviesSearchResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var moviesGenresResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var tvshowsSearchResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var tvshowsGenreResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    init() {
        moviesSearchObservable = PublishSubject()
        moviesGenresObservable = PublishSubject()
        tvshowsSearchObservable = PublishSubject()
        tvshowsGenresObservable = PublishSubject()
    }
    
    func movies(by query:String) {
        moviesSearchResource = api.searchResource?.moviesSearch(with: query)
        moviesSearchResource!.addObserver(owner: self){
            resource, event in
            guard let content:[Media] = resource.typedContent() else { return }
            self.moviesSearchObservable.onNext(content as! [Movie])
            }.loadIfNeeded()
    }
    
    func movies(with genre:Genre) {
        moviesGenresResource = api.discoverResource?.moviesGenres(with: genre)
        moviesGenresResource!.addObserver(owner: self){
            resource, event in
            guard let content:[Media] = resource.typedContent() else { return }
            self.moviesSearchObservable.onNext(content as! [Movie])
            }.loadIfNeeded()
    }
    
    func tvshows(by query:String) {
        tvshowsSearchResource = api.searchResource?.tvshowsSearch(with: query)
        tvshowsSearchResource!.addObserver(owner: self){
            resource, event in
            guard let content:[Media] = resource.typedContent() else { return }
            self.tvshowsSearchObservable.onNext(content as! [TVShow])
            }.loadIfNeeded()
    }
    
    func tvshows(with genre:Genre) {
        tvshowsGenreResource = api.discoverResource?.tvshowsGenres(with: genre)
        tvshowsGenreResource!.addObserver(owner: self){
            resource, event in
            guard let content:[Media] = resource.typedContent() else { return }
            self.tvshowsGenresObservable.onNext(content as! [TVShow])
            }.loadIfNeeded()
    }
    
}
