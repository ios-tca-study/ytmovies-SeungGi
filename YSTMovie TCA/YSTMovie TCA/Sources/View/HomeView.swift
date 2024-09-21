//
//  HomeView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct HomeView: View {
  
  // MARK: - Properties
  
  
  // MARK: - Views
  
  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        topFiveSection()
          .padding(.top, 33)
        
        latestSection()
      }
    }
    .background(.black)
  }
  
  private func topFiveSection() -> some View {
    VStack(spacing: 20) {
      LargeTitleText(title: "Top Five")
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(0..<5) { _ in
            VerticalMovieThumbnailViewRegular(
              title: "title",
              rating: 3.5,
              isBookmarked: false)
          }
        }
        .padding(.horizontal, 16)
      }
    }
  }
  
  private func latestSection() -> some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        LargeTitleText(title: "Latest")
        
        Spacer()
        
        Button {
          
        } label: {
          Text("SEE MORE")
            .font(.system(size: 16))
            .foregroundStyle(.accent)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 16)
      
      VerticalMovieThumbnailViewLarge(
        title: "title",
        rating: 3.5,
        genre: ["Action", "Comedy", "Crime"],
        description: "description",
        isBookmarked: false)
      .padding(16)
    }
  }
}


// MARK: - Preview

#Preview {
  HomeView()
}
