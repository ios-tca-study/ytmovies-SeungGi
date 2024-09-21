//
//  VerticalMovieThumbnailViewRegular.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct VerticalMovieThumbnailViewRegular: View {
  
  // MARK: - Properties
  
  let title: String
  let rating: Double
  let isBookmarked: Bool
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 12) {
      RoundedRectangle(cornerRadius: 15)
        .fill(.gray50)
        .frame(maxWidth: .infinity)
        .aspectRatio(3/2, contentMode: .fit)
      
      VStack(spacing: 4) {
        Text(title)
          .font(.system(size: 20, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 9) {
          Text(rating.description)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(.white)
          
          RatingView(rating: rating, starSize: .regular)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .frame(maxWidth: 300)
    .overlay {
      ZStack {
        (isBookmarked ? Image.bookmark_fill : Image.bookmark)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 24)
          .foregroundStyle(isBookmarked ? .accent : .white)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
      .padding(16)
    }
  }
}

// MARK: - Preview

#Preview {
  ZStack {
    VerticalMovieThumbnailViewRegular(
      title: "titletitletitletitletitletitle",
      rating: 3.5,
      isBookmarked: true)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
