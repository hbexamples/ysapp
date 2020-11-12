//
//  VideosResponse.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
// MARK: - VideosResponse
public struct VideosResponse: Codable {
    public var id: Int?
    public var results: [Result]?

    public init(id: Int?, results: [Result]?) {
        self.id = id
        self.results = results
    }
}

// MARK: - Result
public struct Result: Codable {
    public var id, iso639_1, iso3166_1, key: String?
    public var name, site: String?
    public var size: Int?
    public var type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }

    public init(id: String?, iso639_1: String?, iso3166_1: String?, key: String?, name: String?, site: String?, size: Int?, type: String?) {
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
