//
//  SearchResult.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation
public struct SearchResult: Codable {
    public var page, totalResults, totalPages: Int?
    public var results: [Movie] = []

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    public init(page: Int?, totalResults: Int?, totalPages: Int?, results: [Movie]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
// MARK: - KnownFor
public struct KnownFor: Codable {
    public var posterPath: String?
    public var id, voteCount: Int?
    public var video: Bool?
    public var mediaType: String?
    public var adult: Bool?
    public var backdropPath: String?
    public var genreIDS: [Int]?
    public var originalTitle, originalLanguage, title: String?
    public var voteAverage: Double?
    public var overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case voteCount = "vote_count"
        case video
        case mediaType = "media_type"
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }

    public init(posterPath: String?, id: Int?, voteCount: Int?, video: Bool?, mediaType: String?, adult: Bool?, backdropPath: String?, genreIDS: [Int]?, originalTitle: String?, originalLanguage: String?, title: String?, voteAverage: Double?, overview: String?, releaseDate: String?) {
        self.posterPath = posterPath
        self.id = id
        self.voteCount = voteCount
        self.video = video
        self.mediaType = mediaType
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
    }
}
