//
//  MoviewDetailView.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//


import SwiftUI
import SDWebImageSwiftUI
struct MovieDetailView: View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var movie : Movie
    @State var isFavorite : Bool = false
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                WebImage(url:  URL(string: DataExecuter.Movie.moviePoster(width: 400, posterPath: movie.posterPath ?? "").builder().url) ?? URL.init(fileURLWithPath: ""),options: [SDWebImageOptions.avoidDecodeImage])
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
                Text(movie.overview ?? "")
                    .multilineTextAlignment(.leading)
                    .padding([.leading,.trailing], 16)
                Text("Vote Count : \(movie.voteCount ?? 0)")
                    .fontWeight(.semibold)
                    .padding([.leading,.trailing], 16)
                Text("Rating : \(Int(movie.voteAverage ?? 0))")
                    .fontWeight(.semibold)
                    .padding([.leading,.trailing], 16)
                Section(header:
                            VStack{
                                Text("Videos")
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(height:1.0)
                                if !((self.moviesViewModel.videos.results ?? []).count > 0) {
                                    Text("No Data")
                                        .font(Font.system(size: 15, weight: .bold, design: .serif))
                                        .padding(32)
                                }

                            }.font(Font.system(size: 24, weight: .bold, design: .serif))) {
                    ForEach(self.moviesViewModel.videos.results ?? [],id:\.id) { (row) in
                        YouTubeView(playerState: YouTubeControlState.init(videoId:row.key ?? ""))
                            .frame(height: UIScreen.main.bounds.width * 0.45)
                    }
                }
                LazyVGrid(columns: [GridItem.init(.flexible()),GridItem.init(.flexible())]){
                    Section(header:
                                VStack{
                                    Text("Cast")
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(height:1.0)
                                    if !((self.moviesViewModel.castResponse.cast ?? []).count > 0) {
                                        Text("No Data")
                                            .font(Font.system(size: 15, weight: .bold, design: .serif))
                                            .padding(32)
                                    }

                                }.font(Font.system(size: 24, weight: .bold, design: .serif))) {
                        ForEach(self.moviesViewModel.castResponse.cast ?? [],id:\.id) { (row) in
                            NavigationLink(destination: PersonDetailView(cast: row).environmentObject(self.moviesViewModel)) {
                                CastRow(cast: row)

                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
            }
            
        }
        .navigationBarTitle(Text(movie.title ?? ""), displayMode: .inline)
        .onAppear {
            self.moviesViewModel.getVideos(id: self.movie.ids ?? -1)
            self.moviesViewModel.getCast(id: self.movie.ids ?? -1)

        }
    }
}
