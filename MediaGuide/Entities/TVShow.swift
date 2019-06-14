//
//  TVShow.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import SwiftyJSON
import IGListKit

class TVShow: Codable, Media {
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: Episode?
    let name: String
    let nextEpisodeToAir: Episode?
    let networks: [Network]?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]?
    let seasons: [Season]?
    let status: String?
    let type: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case inProduction = "in_production"
        case languages = "languages"
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name = "name"
        case nextEpisodeToAir = "next_episode_to_air"
        case networks = "networks"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons = "seasons"
        case status = "status"
        case type = "type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(backdropPath: String?, createdBy: [CreatedBy]?, episodeRunTime: [Int]?, firstAirDate: String?, genres: [Genre]?, homepage: String?, id: Int, inProduction: Bool?, languages: [String]?, lastAirDate: String?, lastEpisodeToAir: Episode?, name: String, nextEpisodeToAir: Episode?, networks: [Network]?, numberOfEpisodes: Int?, numberOfSeasons: Int?, originCountry: [String]?, originalLanguage: String?, originalName: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [Network]?, seasons: [Season]?, status: String?, type: String?, voteAverage: Double?, voteCount: Int?) {
        self.backdropPath = backdropPath
        self.createdBy = createdBy
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.lastEpisodeToAir = lastEpisodeToAir
        self.name = name
        self.nextEpisodeToAir = nextEpisodeToAir
        self.networks = networks
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.seasons = seasons
        self.status = status
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

class CreatedBy: Codable {
    let id: Int?
    let creditID: String?
    let name: String?
    let gender: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case creditID = "credit_id"
        case name = "name"
        case gender = "gender"
        case profilePath = "profile_path"
    }
    
    init(id: Int?, creditID: String?, name: String?, gender: Int?, profilePath: String?) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.gender = gender
        self.profilePath = profilePath
    }
}

class Episode: Codable {
    let airDate: String?
    let episodeNumber: Int?
    let id: Int?
    let name: String?
    let overview: String?
    let productionCode: String?
    let seasonNumber: Int?
    let showID: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(airDate: String?, episodeNumber: Int?, id: Int?, name: String?, overview: String?, productionCode: String?, seasonNumber: Int?, showID: Int?, stillPath: String?, voteAverage: Double?, voteCount: Int?) {
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.id = id
        self.name = name
        self.overview = overview
        self.productionCode = productionCode
        self.seasonNumber = seasonNumber
        self.showID = showID
        self.stillPath = stillPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: Convenience initializers and mutators

extension TVShow {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(TVShow.self, from: data)
        self.init(backdropPath: me.backdropPath, createdBy: me.createdBy, episodeRunTime: me.episodeRunTime, firstAirDate: me.firstAirDate, genres: me.genres, homepage: me.homepage, id: me.id, inProduction: me.inProduction, languages: me.languages, lastAirDate: me.lastAirDate, lastEpisodeToAir: me.lastEpisodeToAir, name: me.name, nextEpisodeToAir: me.nextEpisodeToAir, networks: me.networks, numberOfEpisodes: me.numberOfEpisodes, numberOfSeasons: me.numberOfSeasons, originCountry: me.originCountry, originalLanguage: me.originalLanguage, originalName: me.originalName, overview: me.overview, popularity: me.popularity, posterPath: me.posterPath, productionCompanies: me.productionCompanies, seasons: me.seasons, status: me.status, type: me.type, voteAverage: me.voteAverage, voteCount: me.voteCount)
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

extension CreatedBy {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(CreatedBy.self, from: data)
        self.init(id: me.id, creditID: me.creditID, name: me.name, gender: me.gender, profilePath: me.profilePath)
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

extension Episode {
    convenience init(data: Data) throws {
        let me = try altJSONDecoder().decode(Episode.self, from: data)
        self.init(airDate: me.airDate, episodeNumber: me.episodeNumber, id: me.id, name: me.name, overview: me.overview, productionCode: me.productionCode, seasonNumber: me.seasonNumber, showID: me.showID, stillPath: me.stillPath, voteAverage: me.voteAverage, voteCount: me.voteCount)
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

extension TVShow: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self.id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let tvshow = object as? TVShow else { return false }
        
        return self.id == tvshow.id
    }
    
    
}
