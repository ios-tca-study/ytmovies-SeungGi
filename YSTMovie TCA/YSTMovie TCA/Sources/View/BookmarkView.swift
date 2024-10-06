//
//  BookmarkView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct BookmarkView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      navigationView()
        .padding(.top, 33)
      
      searchResult()
    }
    .background(.black)
  }
  
  private func navigationView() -> some View {
    HStack(spacing: 20) {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .font(.system(size: 30, weight: .bold))
          .foregroundStyle(.accent)
      }
      
      LargeTitleText(title: "Bookmarks")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }

  private func searchResult() -> some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        ForEach(0..<10) { _ in
          NavigationLink {
            DetailView()
          } label: {
            PortraitMovieThumbnailViewLarge(movie: .mock)
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 30)
    }
  }
}


// MARK: - Preview

#Preview {
  BookmarkView()
}
