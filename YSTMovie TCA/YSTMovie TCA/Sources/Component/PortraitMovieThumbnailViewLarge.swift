//
//  PortraitMovieThumbnailViewLarge.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import Kingfisher
import ComposableArchitecture

struct PortraitMovieThumbnailViewLarge: View {
  
  // MARK: - Properties
  
  let store: StoreOf<MovieThumbnailFeature>
  typealias ViewStoreType = ViewStore<MovieThumbnailFeature.State, MovieThumbnailFeature.Action>
  
  
  // MARK: - Views
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      HStack(alignment: .top, spacing: 16) {
        ZStack {
          Color.gray50
            .overlay {
              KFImage(URL(string: viewStore.movie.thumbnailImageUrl))
                .resizable()
                .scaledToFill()
            }
          
          ZStack {
            Button {
              store.send(.toggleBookmark)
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
        .aspectRatio(2/3, contentMode: .fit)
        .frame(maxWidth: 182)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
        VStack(spacing: 10) {
          Text(viewStore.movie.title)
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .foregroundStyle(.white)
          
          HStack(spacing: 9) {
            Text(viewStore.movie.rating.description)
              .font(.system(size: 22, weight: .medium))
              .foregroundStyle(.white)
            
            RatingView(rating: viewStore.movie.rating, starSize: .compact)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          Text(viewStore.movie.genre.joined(separator: ", "))
            .font(.system(size: 14))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
          
          Text(viewStore.movie.description)
            .font(.system(size: 13))
            .foregroundStyle(.gray30)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .lineLimit(5)
        }
      }
    }
  }
}


// MARK: - Preview

#Preview {
  let store = Store(initialState: MovieThumbnailFeature.State(movie: .mock)) {
    MovieThumbnailFeature()
  }
  ZStack {
    PortraitMovieThumbnailViewLarge(store: store)
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
