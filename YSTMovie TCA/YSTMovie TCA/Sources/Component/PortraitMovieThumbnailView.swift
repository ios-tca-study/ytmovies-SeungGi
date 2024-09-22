//
//  PortraitMovieThumbnailView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct PortraitMovieThumbnailView: View {
  
  // MARK: - Properties
  
  let title: String
  let rating: Double
  let isBookmarked: Bool
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 5) {
      RoundedRectangle(cornerRadius: 15)
        .fill(.gray50)
        .aspectRatio(2/3, contentMode: .fit)
     
      VStack(spacing: 0) {
        Text(title)
          .font(.system(size: 18, weight: .semibold))
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.white)
        
        HStack(spacing: 5) {
          Text(rating.description)
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
    PortraitMovieThumbnailView(
      title: "titletitletitletitletitletitle",
      rating: 3.5,
      isBookmarked: true)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
