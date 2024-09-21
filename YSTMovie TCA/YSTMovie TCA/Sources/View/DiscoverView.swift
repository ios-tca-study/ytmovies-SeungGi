//
//  DiscoverView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct DiscoverView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  private var columns: [GridItem] = [
    GridItem(.adaptive(minimum: 160, maximum: 300), spacing: 15)
  ]
  
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      navigationView()
        .padding(.top, 33)
      
      ScrollView {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
          ForEach(0..<10) { _ in
            PortraitMovieThumbnailView(
              title: "title",
              rating: 3.5,
              isBookmarked: false)
          }
        }
        .padding(.horizontal, 16)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
    .toolbarVisibility(.hidden, for: .navigationBar)
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
      
      LargeTitleText(title: "Discover")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }
}


// MARK: - Preview

#Preview {
  DiscoverView()
}
