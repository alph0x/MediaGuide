//
//  API.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Siesta
import SwiftyJSON
import Foundation

let api = API()

fileprivate let environment = Environment()

struct Environment {
    let apiKey =   Bundle.main.infoDictionary!["api_key"] as! String
    let baseURL =  Bundle.main.infoDictionary!["base_url"] as! String
    let imageURL = Bundle.main.infoDictionary!["image_url"] as! String
}

class API: Service {
    
    var base: Resource { return resource("3").withParam("api_key", environment.apiKey) }
    
    var tvShowsResource: TVShowsResources?
    var moviesResources: MoviesResources?
    var genresResource: GenresResources?
    var searchResource: SearchResources?
    var discoverResource: DiscoverResources?
    
    init() {
        super.init(baseURL: environment.baseURL)
        
        tvShowsResource = TVShowsResources(self, baseResource: base)
        moviesResources = MoviesResources(self, baseResource: base)
        genresResource = GenresResources(self, baseResource: base)
        searchResource = SearchResources(self, baseResource: base)
        discoverResource = DiscoverResources(self, baseResource: base)
        
        SiestaLog.Category.enabled = [.network, .pipeline, .observers]
        
        self.configure("**") {
            $0.pipeline[.parsing].add(JSONTransformer, contentTypes: ["*/json"])
        }
    }
    
}

private let JSONTransformer =
    ResponseContentTransformer
        { JSON($0.content as AnyObject) }
