//
//  MovieResponse.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import Foundation

public class MovieResponse: BaseResponse {
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
        super.init()
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try? values.decode(Int?.self, forKey: .page)
        totalResults = try? values.decode(Int?.self, forKey: .totalResults)
        totalPages = try? values.decode(Int?.self, forKey: .totalPages)
        results = try values.decode([Movie]?.self, forKey: .results) ?? []
        
        try super.init(from: decoder)
    }
}
