//
//  PersonDetailView.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import SwiftUI
import SDWebImageSwiftUI
struct PersonDetailView: View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var cast : Cast
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                WebImage(url:  URL(string: DataExecuter.Movie.moviePoster(width: 400, posterPath: cast.profilePath ?? "").builder().url) ?? URL.init(fileURLWithPath: ""),options: [SDWebImageOptions.avoidDecodeImage])
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
              
                LazyVGrid(columns: [GridItem.init(.flexible()),GridItem.init(.flexible())]){
                    Section(header:
                                VStack{
                                    Text("Credits")
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(height:1.0)
                                    if !((self.moviesViewModel.castResponse.cast ?? []).count > 0) {
                                        Text("No Data")
                                            .font(Font.system(size: 15, weight: .bold, design: .serif))
                                            .padding(32)
                                    }

                                }.font(Font.system(size: 24, weight: .bold, design: .serif))) {
                        ForEach(self.moviesViewModel.creditsResponse.cast ?? [],id:\.id) { (row) in
                            NavigationLink(destination:MovieDetailView(movie: row)){
                                ResultRow(movie: row)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(cast.name ?? ""), displayMode: .inline)
        .onAppear {
            self.moviesViewModel.getCredits(id: self.cast.id ?? -1)

        }
    }
}
