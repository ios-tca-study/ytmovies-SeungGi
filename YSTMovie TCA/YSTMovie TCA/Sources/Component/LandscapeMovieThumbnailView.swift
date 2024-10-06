//
//  LandscapeMovieThumbnailViewRegular.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher

struct LandscapeMovieThumbnailViewRegular: View {
  
  // MARK: - Properties
  
  let movie: Movie
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 12) {
      ZStack {
        Color.gray50
          .overlay {
            KFImage(URL(string: movie.thumbnailImageUrl))
              .resizable()
              .scaledToFill()
          }
      }
      .frame(maxWidth: .infinity)
      .aspectRatio(3/2, contentMode: .fit)
      .overlay {
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
      .clipShape(RoundedRectangle(cornerRadius: 15))
      
      VStack(spacing: 4) {
        Text(movie.title)
          .font(.system(size: 20, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 9) {
          Text(movie.rating.description)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(.white)
          
          RatingView(rating: movie.rating, starSize: .regular)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .frame(width: 300)
  }
}

// MARK: - Preview

#Preview {
  ZStack {
    LandscapeMovieThumbnailViewRegular(movie: .mock)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
