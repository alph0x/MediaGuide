//
//  Credits.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 08/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import SwiftyJSON
import IGListKit

// MARK: - Credits
class Credits: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
    
    init(id: Int, cast: [Cast], crew: [Crew]) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}

// MARK: Credits convenience initializers and mutators

extension Credits {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Credits.self, from: data)
        self.init(id: me.id, cast: me.cast, crew: me.crew)
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
    
    func with(
        id: Int? = nil,
        cast: [Cast]? = nil,
        crew: [Crew]? = nil
        ) -> Credits {
        return Credits(
            id: id ?? self.id,
            cast: cast ?? self.cast,
            crew: crew ?? self.crew
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Cast
class Cast: Codable {
    let castID: Int
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
    
    init(castID: Int, character: String, creditID: String, gender: Int, id: Int, name: String, order: Int, profilePath: String?) {
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.gender = gender
        self.id = id
        self.name = name
        self.order = order
        self.profilePath = profilePath
    }
}

// MARK: Cast convenience initializers and mutators

extension Cast {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Cast.self, from: data)
        self.init(castID: me.castID, character: me.character, creditID: me.creditID, gender: me.gender, id: me.id, name: me.name, order: me.order, profilePath: me.profilePath)
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
    
    func with(
        castID: Int? = nil,
        character: String? = nil,
        creditID: String? = nil,
        gender: Int? = nil,
        id: Int? = nil,
        name: String? = nil,
        order: Int? = nil,
        profilePath: String?? = nil
        ) -> Cast {
        return Cast(
            castID: castID ?? self.castID,
            character: character ?? self.character,
            creditID: creditID ?? self.creditID,
            gender: gender ?? self.gender,
            id: id ?? self.id,
            name: name ?? self.name,
            order: order ?? self.order,
            profilePath: profilePath ?? self.profilePath
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Crew
class Crew: Codable {
    let creditID, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
    
    init(creditID: String, department: String, gender: Int, id: Int, job: String, name: String, profilePath: String?) {
        self.creditID = creditID
        self.department = department
        self.gender = gender
        self.id = id
        self.job = job
        self.name = name
        self.profilePath = profilePath
    }
}

// MARK: Crew convenience initializers and mutators

extension Crew {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Crew.self, from: data)
        self.init(creditID: me.creditID, department: me.department, gender: me.gender, id: me.id, job: me.job, name: me.name, profilePath: me.profilePath)
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
    
    func with(
        creditID: String? = nil,
        department: String? = nil,
        gender: Int? = nil,
        id: Int? = nil,
        job: String? = nil,
        name: String? = nil,
        profilePath: String?? = nil
        ) -> Crew {
        return Crew(
            creditID: creditID ?? self.creditID,
            department: department ?? self.department,
            gender: gender ?? self.gender,
            id: id ?? self.id,
            job: job ?? self.job,
            name: name ?? self.name,
            profilePath: profilePath ?? self.profilePath
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
