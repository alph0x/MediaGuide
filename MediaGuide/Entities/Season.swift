//
//  Season.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation

class Season: Codable {
    let airDate: String?
    let episodeCount: Int?
    let id: Int
    let name: String?
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    init(airDate: String?, episodeCount: Int?, id: Int, name: String?, overview: String?, posterPath: String?, seasonNumber: Int) {
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
    }
}

extension Season {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(Season.self, from: data)
        self.init(airDate: me.airDate, episodeCount: me.episodeCount, id: me.id, name: me.name, overview: me.overview, posterPath: me.posterPath, seasonNumber: me.seasonNumber)
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
