//
//  BookmarkView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture

struct BookmarkView: View {
  
  // MARK: - Properties
  
  @Bindable var store: StoreOf<BookmarkFeature>
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      navigationView()
        .padding(.top, 33)
      
      if store.isLoading {
        Spacer()
        ProgressView()
        Spacer()
      } else {
        bookmarkMovieListView()
      }
    }
    .background(.black)
    .onFirstAppear {
      store.send(.load)
    }
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

  private func bookmarkMovieListView() -> some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        ForEach(store.movies, id: \.id) { movie in
          NavigationLink {
            let detailFeatureStore = Store(initialState: DetailFeature.State(movie: movie)) {
              DetailFeature()
            }
            DetailView(store: detailFeatureStore)
          } label: {
            let movieThumbnailStore = Store(initialState: MovieThumbnailFeature.State(movie: movie)) {
              MovieThumbnailFeature()
            }
            PortraitMovieThumbnailViewLarge(store: movieThumbnailStore)
              .onFirstAppear {
                if store.isLastPage == false
                    && movie == store.movies.last {
                  store.send(.loadMore)
                }
              }
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 30)
    }
    .refreshable {
      store.send(.load)
    }
  }
}


// MARK: - Preview

#Preview {
  let store = Store(initialState: BookmarkFeature.State()) {
    BookmarkFeature()
  }
  BookmarkView(store: store)
}
