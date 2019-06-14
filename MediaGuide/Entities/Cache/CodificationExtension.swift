//
//  CodificationExtension.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 01/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation

func altJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func altJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
