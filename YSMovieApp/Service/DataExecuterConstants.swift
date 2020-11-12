//
//  DataExecuterConstants.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import Foundation
extension DataExecuter{
    static var language = "en-EN"
    enum Movie {
        case getPopularMovies(page:Int),moviePoster(width:Int,posterPath:String),getVideos(id:Int),getCast(id:Int)
        public func builder() -> ApiRequestBuilder {
            switch self {
                
            case let .getPopularMovies(page):
                return (url:"/movie/popular?language=\(DataExecuter.language)&page=\(page)", action: "GET")
            case let .moviePoster(width,posterPath):
                return (url:"https://image.tmdb.org/t/p/w\(width)\(posterPath)", action: "GET")
            case let .getVideos(id):
                return (url:"/movie/\(id)/videos?language=\(DataExecuter.language)", action: "GET")
            case let .getCast(id):
                return (url:"/movie/\(id)/credits?language=\(DataExecuter.language)", action: "GET")
            }
        }
    }
    enum Person {
        case getCredits(id:Int)
        public func builder() -> ApiRequestBuilder {
            switch self {
                
            case let .getCredits(id):
                return (url:"/person/\(id)/movie_credits?language=\(DataExecuter.language)", action: "GET")
            }
        }
    }
    enum Genre {
        case getGenreList
        public func builder() -> ApiRequestBuilder {
            switch self {
                
            case .getGenreList:
                return (url:"/genre/movie/list?language=\(DataExecuter.language)", action: "GET")
            }
        }
    }
    enum Search {
        case searchMulti(query:String,page:Int)
        public func builder() -> ApiRequestBuilder {
            switch self {
            case let .searchMulti(query,page):
                return (url:"/search/multi?language=\(DataExecuter.language)&query=\(query)&page=\(page)", action: "GET")
            }
        }
    }
}

