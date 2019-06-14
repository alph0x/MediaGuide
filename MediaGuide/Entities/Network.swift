//
//  Network.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation

class Network: Codable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
    init(name: String, id: Int, logoPath: String?, originCountry: String?) {
        self.name = name
        self.id = id
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}

extension Network {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(Network.self, from: data)
        self.init(name: me.name, id: me.id, logoPath: me.logoPath, originCountry: me.originCountry)
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
