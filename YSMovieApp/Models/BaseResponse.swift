//
//  BaseResponse.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import Foundation
public class BaseResponse : Codable{
    public var errors: [String]? = []
    private enum CodingKeys: String, CodingKey {
        case errors
    }
    public init(errors: [String]? = []) {
        self.errors = errors
    }
}
