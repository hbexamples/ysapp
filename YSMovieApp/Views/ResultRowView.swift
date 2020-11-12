//
//  ResultRowView.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI
struct ResultRow : View{
    var movie : Movie? = nil
    var url : URL{
        return URL(string: DataExecuter.Movie.moviePoster(width: 400, posterPath: (movie?.posterPath ?? movie?.profilePath) ?? "").builder().url) ?? URL.init(fileURLWithPath: "")
    }
    var text : String{
        return movie?.title ??  movie?.name ?? ""
    }
    var body : some View{
        ZStack(alignment: .bottom){
            WebImage(url: self.url)
                .resizable()
                .placeholder(content: {
                    ZStack{
                        Color.white.opacity(0.44)
                        
                        VStack{
                            Image.init(systemName: "photo")
                                .padding(32)
                            Text("No Image")
                                .padding(32)
                        }
                    }
                })
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
            
            
            
            
            Text(text)
                .foregroundColor(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .background(Rectangle.init().foregroundColor(.black).opacity(0.80))
            
        }
        .contentShape(Rectangle())
        .clipped()
        
    }
}
