//
//  DetailView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct DetailView: View {
  
  // MARK: - Properties
  
  @Bindable var store: StoreOf<DetailFeature>
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
        .overlay {
          KFImage(URL(string: store.movie.thumbnailImageUrl))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
        }
      
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
      Text(store.movie.title)
        .font(.system(size: 30, weight: .bold))
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
      
      HStack {
        Text("\(Int(store.movie.rating))")
          .font(.system(size: 22, weight: .medium))
          .foregroundStyle(.white)
        
        RatingView(rating: store.movie.rating, starSize: .compact)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(store.movie.genre.joined(separator: ", "))
        .font(.system(size: 14))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(store.movie.description)
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
      .padding(.bottom)
    }
    .padding(.horizontal, 16)
    .background(LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .center))
  }
}


// MARK: - Preview

#Preview {
  let store = Store(initialState: DetailFeature.State(movie: .mock)) {
    DetailFeature()
  }
  DetailView(store: store)
}
