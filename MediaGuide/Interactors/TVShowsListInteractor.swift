//
//  TVShowsListInteractor.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import Siesta
import RxSwift

class TVShowsListInteractor {
    
    let airingTodayObservable:PublishSubject<[TVShow]>
    let popularObservable:PublishSubject<[TVShow]>
    let topRatedObservable:PublishSubject<[TVShow]>
    let onTheAirObservable:PublishSubject<[TVShow]>
    
    var airingTodayResource:Resource? {
        didSet {
        oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var popularResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var topRatedResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var onTheAirResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    init() {
        airingTodayObservable = PublishSubject()
        popularObservable = PublishSubject()
        topRatedObservable = PublishSubject()
        onTheAirObservable = PublishSubject()
    }
    
    func airingToday() {
        airingTodayResource = api.tvShowsResource!.airingToday()
        airingTodayResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                self.airingTodayObservable.onNext(self.handle(resource: resource))
            }
            }.loadIfNeeded()
    }
    
    func popular() {
        popularResource = api.tvShowsResource!.popular()
        popularResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                self.popularObservable.onNext(self.handle(resource: resource))
            }
            }.loadIfNeeded()
    }
    
    func topRated() {
        topRatedResource = api.tvShowsResource!.topRated()
        topRatedResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                self.topRatedObservable.onNext(self.handle(resource: resource))
            }
            }.loadIfNeeded()
    }
    
    func onTheAir() {
        onTheAirResource = api.tvShowsResource!.onTheAir()
        onTheAirResource!.addObserver(owner: self) {
            resource, event in
            if case .newData = event {
                self.onTheAirObservable.onNext(self.handle(resource: resource))
            }
            }.loadIfNeeded()
    }
    
    func handle(resource: Resource) -> [TVShow] {
        guard let content:[TVShow] = resource.typedContent() else { return [] }
        return content
    }

}
