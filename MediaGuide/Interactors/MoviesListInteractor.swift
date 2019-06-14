//
//  MoviesListInteractor.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import RxSwift

class MoviesListInteractor {
    
    let nowPlayingObservable:PublishSubject<[Movie]>
    let popularObservable:PublishSubject<[Movie]>
    let upcomingObservable:PublishSubject<[Movie]>
    let topRatedObservable:PublishSubject<[Movie]>
    
    var nowPlayingResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var popularResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var upcomingResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var topRatedResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    init() {
        nowPlayingObservable = PublishSubject()
        popularObservable = PublishSubject()
        upcomingObservable = PublishSubject()
        topRatedObservable = PublishSubject()
    }
    
    func nowPlaying() {
        nowPlayingResource = api.moviesResources!.nowPlaying()
        nowPlayingResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Movie] = resource.typedContent() else { return }
                self.nowPlayingObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
    
    func popular() {
        popularResource = api.moviesResources!.popular()
        popularResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Movie] = resource.typedContent() else { return }
                self.popularObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
    
    func upcoming() {
        upcomingResource = api.moviesResources!.upcoming()
        upcomingResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Movie] = resource.typedContent() else { return }
                self.upcomingObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
    
    func topRated() {
        topRatedResource = api.moviesResources!.topRated()
        topRatedResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                guard let content:[Movie] = resource.typedContent() else { return }
                self.topRatedObservable.onNext(content)
            }
            }.loadIfNeeded()
    }
    
}
