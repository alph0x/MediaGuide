//
//  GenresResources.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 06/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import UIKit
import Siesta
import SwiftyJSON

class GenresResources {
    
    let resource:Resource
    
    init(_ API: API, baseResource: Resource) {
        API.configure("/3/genre/*"){
            $0.pipeline[.model].cacheUsing(CacheManager<[Genre]>())
        }
        API.configureTransformer("/3/genre/tv/list") {
            try ($0.content as JSON)["genres"].arrayValue.map{try Genre(json: $0)}
        }
        API.configureTransformer("/3/genre/movie/list") {
            try ($0.content as JSON)["genres"].arrayValue.map{try Genre(json: $0)}
        }
        resource = baseResource.child("/genre")
    }
    
    func movieGenres() -> Resource {
        return resource.child("movie/list")
    }
    
    func tvGenres() -> Resource {
        return resource.child("tv/list")
    }

}
