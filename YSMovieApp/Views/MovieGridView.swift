//
//  MovieGridView.swift
//  YSMovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//

import SwiftUI


import SwiftUI
import SDWebImageSwiftUI
struct MovieGrid : View {
    @EnvironmentObject var moviesViewModel : MoviesViewModel
    @Binding var page : Int
    @Binding var columns : Int
    @Binding var filteredList : [Movie]
    @Binding var numItems : Int
    
    var body : some View{
        Group{
            if numItems == 0 || self.filteredList.count == 0{
                ZStack{
                    Text("No Data Found")
                }
            }
            else{
                ForEach(self.filteredList,id:\.id) { (movie) in
                    ZStack{
                        NavigationLink(destination:MovieDetailView( movie: movie)){
                            ResultRow(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.bottom, 16)
                    
                }
                
            }
            
        }
        
    }
    func index(row:Int,column:Int,isBottom : Bool = false) -> Int {
        return isBottom ? ((self.numItems / self.columns) * self.columns) + column : (row * self.columns) + column
    }
}
