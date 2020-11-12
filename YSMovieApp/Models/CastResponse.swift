//
//  CastResponse.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation

// MARK: - CastResponse
public struct CastResponse: Codable {
    public var id: Int?
    public var cast, crew: [Cast]?

    public init(id: Int?, cast: [Cast]?, crew: [Cast]?) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}

// MARK: - Cast
public struct Cast: Codable {
    public var adult: Bool?
    public var gender, id: Int?
    public var knownForDepartment: Department?
    public var originalName: String?
    public var popularity: Double?
    public var profilePath: String?
    public var name: String?
    public var castID: Int?
    public var character, creditID: String?
    public var order: Int?
    public var department: Department?
    public var job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case name
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }

    public init(adult: Bool?, gender: Int?, id: Int?, knownForDepartment: Department?, originalName: String?, popularity: Double?, profilePath: String?, name: String?, castID: Int?, character: String?, creditID: String?, order: Int?, department: Department?, job: String?) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.name = name
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.order = order
        self.department = department
        self.job = job
    }
    
}

public enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
