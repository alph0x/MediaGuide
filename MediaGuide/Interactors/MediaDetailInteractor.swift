//
//  MediaDetailInteractor.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 02/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import Siesta
import RxSwift

class MediaDetailInteractor {
    
    let movies = api.moviesResources
    let tvshows = api.tvShowsResource
    
    let detailsObservable:PublishSubject<Media>
    let creditsObservable:PublishSubject<Credits>
    let videosObservable:PublishSubject<[Video]>
    let similarObservable:PublishSubject<[Any]>
    let reviewsObservable:PublishSubject<[Any]>
    
    init() {
        detailsObservable = PublishSubject()
        creditsObservable = PublishSubject()
        videosObservable = PublishSubject()
        similarObservable = PublishSubject()
        reviewsObservable = PublishSubject()
    }
    
    var detailsResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var creditsResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var videosResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var similarResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    var reviewsResource:Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
        }
    }
    
    func details(for media:Any) {
        if let movie = media as? Movie {
            guard let moviesResource = movies else { return }
            detailsResource = moviesResource.movie(id: "\(movie.id)")
        }
        
        if let tvshow = media as? TVShow {
            guard let tvshowsResources = api.tvShowsResource else { return }
            detailsResource = tvshowsResources.tvShow(id: "\(tvshow.id)")
        }
        
        detailsResource!.addObserver(owner: self) {
            resource, event in
            guard let content:Media = resource.typedContent() else { return }
            self.detailsObservable.onNext(content)
            }.load()
    }
    
    func credits(for media:Any) {
        if let movie = media as? Movie {
            guard let moviesResource = movies else { return }
            creditsResource = moviesResource.credits(id: "\(movie.id)")
        }
        
        if let tvshow = media as? TVShow {
            guard let tvshowsResources = api.tvShowsResource else { return }
            creditsResource = tvshowsResources.credits(id: "\(tvshow.id)")
        }
        
        creditsResource!.addObserver(owner: self) {
            resource, event in
            guard let content:Credits = resource.typedContent() else { return }
            self.creditsObservable.onNext(content)
            }.load()
    }
    
    func videos(for media:Any) {
        if let movie = media as? Movie {
            guard let moviesResource = movies else { return }
            videosResource = moviesResource.videos(id: "\(movie.id)")
        }
        
        if let tvshow = media as? TVShow {
            guard let tvshowsResources = api.tvShowsResource else { return }
            videosResource = tvshowsResources.videos(id: "\(tvshow.id)")
        }
        
        videosResource!.addObserver(owner: self) {
            resource, event in
            guard let content:[Video] = resource.typedContent() else { return }
            self.videosObservable.onNext(content)
            }.load()
    }
    
    func similar(for media:Any) {
        if let movie = media as? Movie {
            guard let moviesResource = movies else { return }
            similarResource = moviesResource.similar(id: "\(movie.id)")
        }
        
        if let tvshow = media as? TVShow {
            guard let tvshowsResources = api.tvShowsResource else { return }
            similarResource = tvshowsResources.similar(id: "\(tvshow.id)")
        }
        
        similarResource!.addObserver(owner: self) {
            resource, event in
            guard let content:[Any] = resource.typedContent() else { return }
            self.similarObservable.onNext(content)
            }.load()
    }
    
    func reviews(for media:Media) {
        if let movie = media as? Movie {
            guard let moviesResource = movies else { return }
            reviewsResource = moviesResource.reviews(id: "\(movie.id)")
        }
        
        if let tvshow = media as? TVShow {
            guard let tvshowsResources = api.tvShowsResource else { return }
            reviewsResource = tvshowsResources.reviews(id: "\(tvshow.id)")
        }
        
        reviewsResource!.addObserver(owner: self) {
            resource, event in
            guard let content:[Any] = resource.typedContent() else { return }
            self.reviewsObservable.onNext(content)
            }.load()
    }
    
}
