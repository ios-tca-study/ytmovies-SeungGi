//
//  DetailView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI

struct DetailView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      Color.gray30
        .ignoresSafeArea()
      
      VStack {
        navigationBar()
        
        Spacer()
        
        contentView()
      }
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
  
  private func navigationBar() -> some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .font(.system(size: 24, weight: .bold))
          .foregroundStyle(.white)
      }
      
      Spacer()
      
      Button {
        
      } label: {
        Image.bookmark
          .resizable()
          .scaledToFit()
          .frame(height: 24)
          .foregroundStyle(.white)
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 43)
  }
  
  private func contentView() -> some View {
    VStack(spacing: 10) {
      Text("Title")
        .font(.system(size: 30, weight: .bold))
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
      
      HStack {
        Text("3.5")
          .font(.system(size: 22, weight: .medium))
          .foregroundStyle(.white)
        
        RatingView(rating: 3.5, starSize: .compact)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Text("Action, Comedy, Crime")
        .font(.system(size: 14))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text("The world's most lethal odd couple - bodyguard Michael Bryce and Darius Kincaid - are back on anoth most lethal odd couple - bodyguard Michael Bryce anan Darius Kincaid....")
        .font(.system(size: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
        .multilineTextAlignment(.leading)
        .foregroundStyle(.gray10)
      
      Button {
        
      } label: {
        RoundedRectangle(cornerRadius: 5)
          .fill(.accent)
          .frame(maxWidth: .infinity, maxHeight: 50)
          .overlay {
            Text("DOWNLOAD TORRENT")
              .font(.system(size: 16, weight: .medium))
              .foregroundStyle(.black)
          }
      }
      .frame(maxWidth: .infinity)
      .padding(.top, 7)
    }
    .padding(.horizontal, 16)
    .background(LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom))
  }
}


// MARK: - Preview

#Preview {
  DetailView()
}
