//
//  Genre.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import SwiftyJSON
import IGListKit

class Genre: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(Genre.self, from: data)
        self.init(id: me.id, name: me.name)
    }
    
    convenience init(json: JSON) throws{
        let jsonData = try json.rawData()
        try self.init(data: jsonData)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
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

extension Genre: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let movie = object as? Movie else { return false }
        
        return self.id == movie.id
    }
    
}

