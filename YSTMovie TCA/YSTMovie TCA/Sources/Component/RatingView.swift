//
//  RatingView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct RatingView: View {
  
  // MARK: - Properties
  
  let rating: Double
  let starSize: StarSize
  
  enum StarSize {
    case compact
    case regular
    
    var size: CGFloat {
      switch self {
      case .compact:
        return 20
      case .regular:
        return 24
      }
    }
  }
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(spacing: 5) {
      ForEach(0..<5) { index in
        let currentRating = rating - Double(index)
        if currentRating >= 1 {
          Image.star_fill
            .resizable()
            .frame(width: starSize.size, height: starSize.size)
        } else if currentRating == 0.5 {
          Image.star_half
            .resizable()
            .frame(width: starSize.size, height: starSize.size)
        } else {
          Image.star_empty
            .resizable()
            .frame(width: starSize.size, height: starSize.size)
        }
      }
    }
  }
}

// MARK: - Preview

#Preview {
  VStack {
    ForEach(Array(stride(from: 0, to: 5.5, by: 0.5).enumerated()), id: \.offset) { _, rating in
      RatingView(rating: rating, starSize: .regular)
        .padding(.bottom, 10)
    }
  }
  .padding()
}
