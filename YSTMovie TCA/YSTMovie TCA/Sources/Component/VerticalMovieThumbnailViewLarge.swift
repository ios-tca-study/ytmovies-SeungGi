//
//  VerticalMovieThumbnailViewLarge.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct VerticalMovieThumbnailViewLarge: View {
  
  // MARK: - Properties
  
  let title: String
  let rating: Double
  let genre: [String]
  let description: String
  let isBookmarked: Bool
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      RoundedRectangle(cornerRadius: 15)
        .fill(.gray50)
        .aspectRatio(2/3, contentMode: .fit)
        .frame(maxWidth: 182)
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
      
      VStack(spacing: 10) {
        Text(title)
          .font(.system(size: 20, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 9) {
          Text(rating.description)
            .font(.system(size: 22, weight: .medium))
            .foregroundStyle(.white)
          
          RatingView(rating: rating, starSize: .compact)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(genre.joined(separator: ", "))
          .font(.system(size: 14))
          .foregroundStyle(.white)
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
        
        Text(description)
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
    VerticalMovieThumbnailViewLarge(
      title: "Hitman’s Wife’s Bodyguard",
      rating: 3.5,
      genre: ["Action", "Comedy", "Crime"],
      description: "The world's most lethal odd couple - bodyguard Michael Bryce and hitman Darius Kincaid - are back on anoth",
      isBookmarked: false)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
