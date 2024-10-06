//
//  PortraitMovieThumbnailViewLarge.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher

struct PortraitMovieThumbnailViewLarge: View {
  
  // MARK: - Properties
  
  let movie: Movie
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      ZStack {
        Color.gray50
          .overlay {
            KFImage(URL(string: movie.thumbnailImageUrl))
              .resizable()
              .scaledToFill()
          }
        
        ZStack {
          (movie.isBookmarked ? Image.bookmark_fill : Image.bookmark)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 24)
            .foregroundStyle(movie.isBookmarked ? .accent : .white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(16)
      }
      .aspectRatio(2/3, contentMode: .fit)
      .frame(maxWidth: 182)
      .overlay {
        
      }
      .clipShape(RoundedRectangle(cornerRadius: 15))
      
      VStack(spacing: 10) {
        Text(movie.title)
          .font(.system(size: 20, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 9) {
          Text(movie.rating.description)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(.white)
          
          RatingView(rating: movie.rating, starSize: .compact)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(movie.genre.joined(separator: ", "))
          .font(.system(size: 14))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
        
        Text(movie.description)
          .font(.system(size: 13))
          .foregroundStyle(.gray30)
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
      }
    }
  }
}


// MARK: - Preview

#Preview {
  ZStack {
    PortraitMovieThumbnailViewLarge(movie: .mock)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
