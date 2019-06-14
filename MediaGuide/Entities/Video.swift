//
//  Video.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import SwiftyJSON

class Video: Codable {
    let id: String?
    let iso639_1: String?
    let iso3166_1: String?
    let key: String?
    let name: String?
    let site: String?
    let size: Int?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key = "key"
        case name = "name"
        case site = "site"
        case size = "size"
        case type = "type"
    }
    
    init(id: String?, iso639_1: String?, iso3166_1: String?, key: String?, name: String?, site: String?, size: Int?, type: String?) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}

// MARK: Convenience initializers and mutators

extension Video {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(Video.self, from: data)
        self.init(id: me.id, iso639_1: me.iso639_1, iso3166_1: me.iso3166_1, key: me.key, name: me.name, site: me.site, size: me.size, type: me.type)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(json: JSON) throws{
        let jsonData = try json.rawData()
        try self.init(data: jsonData)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try altJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
