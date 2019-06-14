//
//  MoviesResources.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class MoviesResources {
    
    let resource: Resource
    
    init(_ API: API, baseResource: Resource) {
        API.configure("/3/movie/*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[Movie]>())
        }
        API.configureTransformer("/3/movie/*") {
            try Movie(json: $0.content as JSON)
        }
        API.configureTransformer("/3/movie/reviews") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/similar") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/popular") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/now_playing") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/upcoming") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/latest") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/top_rated") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/movie/*/videos") {
            try ($0.content as JSON)["results"].arrayValue.map{try Video(json: $0)}
        }
        API.configureTransformer("/3/movie/*/credits") {
            try Credits(json: $0.content as JSON)
        }
        API.configureTransformer("/3/movie/*/similar") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        resource = baseResource.child("/movie")
    }
    
    func movie(id: String) -> Resource {
        return resource.child(id)
    }
    
    func credits(id: String) -> Resource {
        return resource.child(id).child("credits")
    }
    
    func videos(id: String) -> Resource {
        return resource.child(id).child("videos")
    }
    
    func reviews(id: String) -> Resource {
        return resource.child(id).child("reviews")
    }
    
    func similar(id: String) -> Resource {
        return resource.child(id).child("similar")
    }
    
    func popular() -> Resource {
        return resource.child("popular")
    }
    
    func nowPlaying() -> Resource {
        return resource.child("now_playing")
    }
    
    func upcoming() -> Resource {
        return resource.child("upcoming")
    }
    
    func latest() -> Resource {
        return resource.child("latest")
    }
    
    func topRated() -> Resource {
        return resource.child("top_rated")
    }
    
    
}
