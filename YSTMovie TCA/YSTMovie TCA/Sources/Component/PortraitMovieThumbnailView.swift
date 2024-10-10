//
//  PortraitMovieThumbnailView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher

struct PortraitMovieThumbnailView: View {
  
  // MARK: - Properties
  
  let movie: Movie
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 5) {
      ZStack {
        Color.gray50
          .overlay {
            KFImage(URL(string: movie.thumbnailImageUrl))
              .resizable()
              .aspectRatio(contentMode: .fill)
          }
      }
      .aspectRatio(2/3, contentMode: .fit)
      .clipShape(RoundedRectangle(cornerRadius: 15))
     
      VStack(spacing: 0) {
        Text(movie.title)
          .font(.system(size: 18, weight: .semibold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 5) {
          Text(movie.rating.description)
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(.white)
          
          Image.star_fill
            .resizable()
            .frame(width: 20, height: 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .frame(maxWidth: .infinity)
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
  }
}


// MARK: - Preview

#Preview {
  ZStack {
    PortraitMovieThumbnailView(movie: .mock)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
