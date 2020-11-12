//
//  Movie.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import Foundation

public struct Movie: Codable,Identifiable {
    public var id = UUID()
    public var ids : Int?
    public var knownForDepartment: String?
    public var name: String?
    public var knownFor: [KnownFor]?
    public var popularity: Double?
    public var profilePath: String?
    public var gender: Int?
    public var mediaType: MediaType?
    public var adult: Bool?
    public var voteCount: Int?
    public var video: Bool?
    public var voteAverage: Double?
    public var title, releaseDate: String?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var genreIDS: [Int]?
    public var backdropPath: String?
    public var overview: String?
    public var posterPath: String?
    public var originalName: String?
    public var originCountry: [String]?
    public var firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        case ids = "id"

        case knownFor = "known_for"
        case popularity
        case profilePath = "profile_path"
        case gender
        case mediaType = "media_type"
        case adult
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
    }

    public init(knownForDepartment: String?, name: String?, knownFor: [KnownFor]?, popularity: Double?, profilePath: String?, gender: Int?, mediaType: MediaType?, adult: Bool?, voteCount: Int?, video: Bool?, voteAverage: Double?, title: String?, releaseDate: String?, originalLanguage: String?, originalTitle: String?, genreIDS: [Int]?, backdropPath: String?, overview: String?, posterPath: String?, originalName: String?, originCountry: [String]?, firstAirDate: String?,ids:Int?) {
        self.knownForDepartment = knownForDepartment
        self.ids = ids
        self.name = name
        self.knownFor = knownFor
        self.popularity = popularity
        self.profilePath = profilePath
        self.gender = gender
        self.mediaType = mediaType
        self.adult = adult
        self.voteCount = voteCount
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.releaseDate = releaseDate
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.backdropPath = backdropPath
        self.overview = overview
        self.posterPath = posterPath
        self.originalName = originalName
        self.originCountry = originCountry
        self.firstAirDate = firstAirDate
    }
    func toCast() -> Cast {
        return Cast.init(adult: adult, gender: gender, id: ids, knownForDepartment: nil, originalName: originalName, popularity: popularity, profilePath: profilePath, name: name, castID: ids, character: nil, creditID: nil, order: nil, department: nil, job: nil)
    }
}

public enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
