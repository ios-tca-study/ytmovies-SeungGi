//
//  SearchView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct SearchView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      navigationView()
        .padding(.top, 33)
      
      textField()
        .padding(.horizontal, 16)
      
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
      
      LargeTitleText(title: "Search")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }
  
  private func textField() -> some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(.gray70)
      .frame(maxWidth: .infinity, maxHeight: 70)
      .overlay {
        HStack(spacing: 16) {
          Image.search
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(.white)
          
          TextField("Search", text: .constant(""))
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
        }
        .padding(.horizontal, 16)
      }
  }
  
  private func searchResult() -> some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        ForEach(0..<10) { _ in
          VerticalMovieThumbnailViewLarge(
            title: "title",
            rating: 3.5,
            genre: ["Action", "Comedy", "Crime"],
            description: "description",
            isBookmarked: false)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 30)
    }
  }
}


// MARK: - Preview

#Preview {
  SearchView()
}
