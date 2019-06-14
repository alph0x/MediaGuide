//
//  DiscoverResources.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 13/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class DiscoverResources: NSObject {
    
    let resource: Resource
    
    init(_ API: API, baseResource: Resource) {
        API.configure("/3/discover/movie*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[Movie]>())
        }
        API.configure("/3/discover/tv*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[TVShow]>())
        }
        API.configureTransformer("/3/discover/movie*") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/discover/tv*") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        
        resource = baseResource.child("/discover")
    }
    
    func moviesGenres(with genre:Genre) -> Resource {
        return resource.child("movie").withParam("language", "en-US").withParam("page", "1").withParam("with_genres", "\(genre.id)")
    }
    
    func tvshowsGenres(with genre:Genre) -> Resource {
        return resource.child("tv").withParam("language", "en-US").withParam("page", "1").withParam("with_genres", "\(genre.id)")
    }
}
