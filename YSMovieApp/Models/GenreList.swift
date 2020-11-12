//
//  GenreList.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import Foundation

// MARK: - GenreList
public struct GenreList: Codable {
    public var genres: [Genre]?

    public init(genres: [Genre]?) {
        self.genres = genres
    }
}

// MARK: - Genre
public struct Genre: Codable,Identifiable {
    public var id: Int
    public var name: String?

    public init(id: Int, name: String?) {
        self.id = id
        self.name = name
    }
}
