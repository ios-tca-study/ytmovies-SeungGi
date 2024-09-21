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
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(spacing: 5) {
      ForEach(0..<5) { index in
        let currentRating = rating - Double(index)
        if currentRating >= 1 {
          Image.star_fill
            .resizable()
            .frame(width: 24, height: 24)
        } else if currentRating == 0.5 {
          Image.star_half
            .resizable()
            .frame(width: 24, height: 24)
        } else {
          Image.star_empty
            .resizable()
            .frame(width: 24, height: 24)
        }
      }
    }
  }
}

// MARK: - Preview

#Preview {
  VStack {
    ForEach(Array(stride(from: 0, to: 5.5, by: 0.5).enumerated()), id: \.offset) { _, rating in
      RatingView(rating: rating)
        .padding(.bottom, 10)
    }
  }
  .padding()
}
