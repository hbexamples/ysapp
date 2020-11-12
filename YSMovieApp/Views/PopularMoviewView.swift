//
//  PopularMoviewView.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import SwiftUI
import SDWebImageSwiftUI
struct PopularMoviesView: View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var genres = GenreList.init(genres: nil)
    @State var page = 1
    @State var columns = 1
    @State var searchText :String = ""
    @State var filteredList : [Movie] = []
    @State var numItems : Int = 0
    @State var serviceState : ServiceStates = .loading
    var body: some View {
        NavigationView{
            Group{
                ScrollView{
                    SearchBar(text: self.$searchText,textChanged: {
                        self.page = 1
                        if self.searchText == ""{
                             self.numItems = self.moviesViewModel.movieResponse.results.count
                            self.filteredList = self.moviesViewModel.movieResponse.results
                            self.genres = GenreList.init(genres: nil)
                            self.moviesViewModel.searchResult = SearchResult.init(page: nil, totalResults: nil, totalPages: nil, results: [])
                        }
                        else{
                            
                            self.numItems = self.moviesViewModel.movieResponse.results.filter({ ($0.title ?? "").lowercased().contains(self.searchText.lowercased()) }).count
                            self.filteredList = self.moviesViewModel.movieResponse.results.filter({ ($0.title ?? "").lowercased().contains(self.searchText.lowercased()) })
                            self.genres = GenreList.init(genres: (self.moviesViewModel.genreList.genres ?? []).filter({ $0.name?.lowercased().contains(self.searchText.lowercased()) ?? false}))
                            self.moviesViewModel.search(page: self.page, query: self.searchText) {
                                
                            }
                            
                        }
                    })
                    .padding([.leading,.trailing],16)
                    if (self.genres.genres?.count ?? 0) > 0 {
                        VStack{
                            Text("Genres")
                            Rectangle()
                                .fill(Color.white)
                                .frame(height:1.0)
                            
                        }
                        .font(Font.system(size: 24, weight: .bold, design: .serif))
                        LazyVGrid(columns: [GridItem.init(.flexible()),GridItem.init(.flexible())]){
                            ForEach(self.genres.genres ?? [] ,id:\.id){ genre in
                                ZStack{
                                    Color.gray.opacity(0.44).frame(minWidth:0,maxWidth:.infinity)
                                    Text(genre.name ?? "")
                                        .font(Font.system(size: 15, weight: .bold, design: .serif))
                                        .padding(.vertical,32)
                                }
                                
                                
                                
                            }
                        }
                    }
                    if self.searchText.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
                        if self.moviesViewModel.searchState == .loading{
                            ProgressView()
                        }
                        else{
                            LazyVGrid(columns: [GridItem.init(.flexible()),GridItem.init(.flexible())]){
                                 
                                    Section(header:
                                        
                                                VStack{
                                                    Text("Person")
                                                    Rectangle()
                                                        .fill(Color.white)
                                                        .frame(height:1.0)
                                                    if !((self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.person})).count > 0) {
                                                        Text("No Data")
                                                            .font(Font.system(size: 15, weight: .bold, design: .serif))
                                                            .padding(32)
                                                    }
                                                }
                                                .font(Font.system(size: 24, weight: .bold, design: .serif))) {
                                        Group{
                                            ForEach(self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.person}),id:\.id) { (row) in
                                                NavigationLink(destination: PersonDetailView(cast: row.toCast()).environmentObject(self.moviesViewModel)) {
                                                    ResultRow(movie: row)
                                                }
                                                .buttonStyle(PlainButtonStyle())

                                            }
                                        }
                                        
                                    }
                                        
                                    Section(header:
                                                VStack{
                                                    Text("Movie")
                                                    Rectangle()
                                                        .fill(Color.white)
                                                        .frame(height:1.0)
                                                    if !((self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.movie})).count > 0) {
                                                        Text("No Data")
                                                            .font(Font.system(size: 15, weight: .bold, design: .serif))
                                                            .padding(32)
                                                    }

                                                }.font(Font.system(size: 24, weight: .bold, design: .serif))) {
                                        ForEach(self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.movie}),id:\.id) { (row) in
                                            NavigationLink(destination:MovieDetailView( movie: row)){
                                                ResultRow(movie: row)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                        
                                    Section(header:
                                                VStack{
                                                    Text("TV-Series")
                                                    Rectangle()
                                                        .fill(Color.white)
                                                        .frame(height:1.0)
                                                    if !((self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.tv})).count > 0) {
                                                        Text("No Data")
                                                            .font(Font.system(size: 15, weight: .bold, design: .serif))
                                                            .padding(32)
                                                    }
                                                    
                                                }
                                                .font(Font.system(size: 24, weight: .bold, design: .serif))) {
                                        ForEach(self.moviesViewModel.searchResult.results.filter({ $0.mediaType == MediaType.tv}),id:\.id) { (row) in
                                            NavigationLink(destination:MovieDetailView( movie: row)){
                                                ResultRow(movie: row)
                                            }
                                            .buttonStyle(PlainButtonStyle())

                                        }
                                    }
                        
                    }
                        }
                    }
                    else{
                        LazyVGrid(columns: [GridItem.init(.flexible()),GridItem.init(.flexible())]){
                            MovieGrid(page: self.$page, columns: self.$columns, filteredList: self.$filteredList,numItems:self.$numItems)
                        }
                    }
                    
                    if self.searchText == ""{
                        if self.serviceState == .loading{
                            ProgressView()
                        }
                        else{
                            Button(action: {
                                self.serviceState = .loading
                                self.page += 1
                                self.moviesViewModel.getPopularMovies(page: self.page){
                                    self.numItems = self.moviesViewModel.movieResponse.results.count
                                    self.filteredList = self.moviesViewModel.movieResponse.results
                                    DispatchQueue.main.async{
                                        self.serviceState = .success
                                    }
                                }
                                
                            }) {
                                VStack(alignment:.center){
                                    
                                    Text("Load More")
                                        .fontWeight(.semibold)
                                        .underline()
                                    Spacer()
                                        .frame(height:0)
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
            .navigationBarTitle(String.movies)
        }
        .accentColor(self.colorScheme == .light ? .black : .white)
        .onAppear {
            self.moviesViewModel.getGenres()
            self.moviesViewModel.getPopularMovies(page: self.page){
                self.numItems = self.moviesViewModel.movieResponse.results.count
                self.filteredList = self.moviesViewModel.movieResponse.results
                self.serviceState = .success
            }
            UITableView.appearance().tableFooterView = UIView()
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().selectionStyle = .none
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableViewCell.appearance().contentView.backgroundColor = .clear
        }
    }
}
