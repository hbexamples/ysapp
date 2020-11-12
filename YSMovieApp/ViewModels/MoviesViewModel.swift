//
//  MoviesViewModel.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//


import SwiftUI
class MoviesViewModel: ObservableObject {
   @Published var movieResponse : MovieResponse = MovieResponse.init(page: nil, totalResults: nil, totalPages: nil, results: [])
   @Published var genreList = GenreList.init(genres: nil)
   @Published var searchResult = SearchResult.init(page: nil, totalResults: nil, totalPages: nil, results: [])
   @Published var errorMessage  = ""
   @Published var searchState = ServiceStates.loading
   @Published var getVideosState = ServiceStates.loading
   @Published var getCastingState = ServiceStates.loading
   @Published var getCreditsState = ServiceStates.loading
   @Published var state = ServiceStates.loading
   @Published var videos = VideosResponse.init(id: nil, results: nil)
   @Published var castResponse = CastResponse.init(id: nil, cast: nil, crew: nil)
   @Published var creditsResponse = CreditsResponse.init(cast: nil, crew: nil)
   
   var isFirstPage = true
   
   func getPopularMovies(page:Int, completion: @escaping () -> Void) {
       isFirstPage = page == 0
       self.state = .loading
       
       let builder = DataExecuter.Movie.getPopularMovies(page: page).builder()
       DataExecuter.Request.init(builder: builder).execute(type: MovieResponse.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               if self?.isFirstPage ?? false {
                   self?.movieResponse = data
               }
               else{
                   self?.movieResponse.results.append(contentsOf: data.results)
               }
               DispatchQueue.main.async {
                   self?.state = .success
               }
               completion()
           }
           else{
               self?.errorMessage = errorMessage ?? String.unExpectedError
               self?.state = .error
           }
       }
   }
   func search(page:Int,query:String, completion: @escaping () -> Void) {
       let  isFirstPage = page == 1
       let builder = DataExecuter.Search.searchMulti(query: query,page:page).builder()
       searchState = .loading
       DataExecuter.Request.init(builder: builder).execute(type: SearchResult.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               DispatchQueue.main.async {
                   self?.searchState = .success

                   if isFirstPage {
                       
                       self?.searchResult = data
                       
                   }
                   else{
                       self?.searchResult.results.append(contentsOf: data.results)
                   }
               }
               completion()
           }
           else{
               DispatchQueue.main.async {
                   self?.searchState = .error
               }
           }
       }
   }
   func getGenres() {
       let builder = DataExecuter.Genre.getGenreList.builder()
       DataExecuter.Request.init(builder: builder).execute(type: GenreList.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               DispatchQueue.main.async {
                   self?.genreList = data
               }
           }
       }
   }
   func getVideos(id:Int)  {
       let builder = DataExecuter.Movie.getVideos(id: id).builder()
       getVideosState = .loading
       DataExecuter.Request.init(builder: builder).execute(type: VideosResponse.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               DispatchQueue.main.async {
                   self?.videos = data
                   self?.getVideosState = .success
               }
           }
           else{
               DispatchQueue.main.async {
                   self?.getVideosState = .error
               }
           }
       }
   }
   func getCast(id:Int)  {
       let builder = DataExecuter.Movie.getCast(id: id).builder()
       getCastingState = .loading
       DataExecuter.Request.init(builder: builder).execute(type: CastResponse.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               DispatchQueue.main.async {
                   self?.castResponse = data
                   self?.getCastingState = .success
               }
           }
           else{
               DispatchQueue.main.async {
                   self?.getCastingState = .error
               }
           }
       }
   }
   func getCredits(id:Int)  {
       let builder = DataExecuter.Person.getCredits(id: id).builder()
       getCastingState = .loading
       DataExecuter.Request.init(builder: builder).execute(type: CreditsResponse.self) { [weak self] (response, isSuccess, errorMessage) in
           if let data = response,isSuccess{
               DispatchQueue.main.async {
                   self?.creditsResponse = data
                   self?.getCastingState = .success
               }
           }
           else{
               DispatchQueue.main.async {
                   self?.getCastingState = .error
               }
           }
       }
   }
  
}
