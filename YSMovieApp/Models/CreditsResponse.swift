//
//  CreditsResponse.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//


import Foundation

// MARK: - CastResponse
public struct CreditsResponse: Codable {
    public var cast, crew: [Movie]?

    public init(cast: [Movie]?, crew: [Movie]?) {
        self.cast = cast
        self.crew = crew
    }
}
