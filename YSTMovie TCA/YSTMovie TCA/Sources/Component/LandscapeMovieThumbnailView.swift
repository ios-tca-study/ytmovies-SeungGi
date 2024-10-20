//
//  LandscapeMovieThumbnailViewRegular.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct LandscapeMovieThumbnailViewRegular: View {
  
  // MARK: - Properties
  
  let store: StoreOf<MovieThumbnailFeature>
  typealias ViewStoreType = ViewStore<MovieThumbnailFeature.State, MovieThumbnailFeature.Action>
  
  
  // MARK: - Views
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack(spacing: 12) {
        ZStack {
          Color.gray50
            .overlay {
              KFImage(URL(string: viewStore.movie.thumbnailImageUrl))
                .resizable()
                .scaledToFill()
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(3/2, contentMode: .fit)
        .overlay {
          ZStack {
            Button {
              viewStore.send(.toggleBookmark)
            } label: {
              (viewStore.movie.isBookmarked ? Image.bookmark_fill : Image.bookmark)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
                .foregroundStyle(viewStore.movie.isBookmarked ? .accent : .white)
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
          .padding(16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
        VStack(spacing: 4) {
          Text(viewStore.movie.title)
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.white)
          
          HStack(spacing: 9) {
            Text(viewStore.movie.rating.description)
              .font(.system(size: 22, weight: .medium))
              .foregroundStyle(.white)
            
            RatingView(rating: viewStore.movie.rating, starSize: .regular)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
      }
      .frame(width: 300)
    }
  }
}

// MARK: - Preview

#Preview {
  let store = Store(initialState: MovieThumbnailFeature.State(movie: .mock)) {
    MovieThumbnailFeature()
  }
  ZStack {
    LandscapeMovieThumbnailViewRegular(store: store)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
