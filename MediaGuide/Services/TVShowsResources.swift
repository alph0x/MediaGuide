//
//  TVShowsResources.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class TVShowsResources {
    
    let resource: Resource
    
    init(_ API: API, baseResource: Resource) {
        API.configure("/3/tv/*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[TVShow]>())
        }
        API.configureTransformer("/3/tv/*") {
            try TVShow(json: $0.content as JSON)
        }
        API.configureTransformer("/3/tv/airing_today") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        API.configureTransformer("/3/tv/on_the_air") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        API.configureTransformer("/3/tv/popular") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        API.configureTransformer("/3/tv/top_rated") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        API.configureTransformer("/3/tv/similar") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        API.configureTransformer("/3/tv/*/videos") {
            try ($0.content as JSON)["results"].arrayValue.map{try Video(json: $0)}
        }
        API.configureTransformer("/3/tv/*/credits") {
            try ($0.content as JSON).arrayValue.map{try Credits(json: $0)}
        }
        API.configureTransformer("/3/tv/*/similar") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        resource = baseResource.child("/tv")
    }
    
    func tvShow() -> Resource {
        return resource
    }
    
    func credits(id: String) -> Resource {
        return resource.child(id).child("credits")
    }
    
    func videos(id: String) -> Resource {
        return resource.child(id).child("videos")
    }
    
    func tvShow(id: String) -> Resource {
        return resource.child(id)
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
    
    func airingToday() -> Resource {
        return resource.child("airing_today")
    }
    
    func onTheAir() -> Resource {
        return resource.child("on_the_air")
    }
    
    func topRated() -> Resource {
        return resource.child("top_rated")
    }
    
}
