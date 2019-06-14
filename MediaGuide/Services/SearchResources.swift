//
//  SearchResources.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

class SearchResources {

    let resource: Resource
    
    init(_ API: API, baseResource: Resource) {
        API.configure("/3/search/movie*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[Movie]>())
        }
        API.configure("/3/search/tv*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[TVShow]>())
        }
        API.configureTransformer("/3/search/movie*") {
            try ($0.content as JSON)["results"].arrayValue.map{try Movie(json: $0)}
        }
        API.configureTransformer("/3/search/tv*") {
            try ($0.content as JSON)["results"].arrayValue.map{try TVShow(json: $0)}
        }
        
        resource = baseResource.child("/search")
    }
    
    func moviesSearch(with query:String) -> Resource {
        return resource.child("movie").withParam("language", "en-US").withParam("page", "1").withParam("query", query)
    }
    
    func tvshowsSearch(with query:String) -> Resource {
        return resource.child("tv").withParam("language", "en-US").withParam("page", "1").withParam("query", query)
    }
    
}
