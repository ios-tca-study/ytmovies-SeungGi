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
  
  var store: StoreOf<BookmarkFeature>
  typealias ViewStoreType = ViewStore<BookmarkFeature.State, BookmarkFeature.Action>
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        navigationView()
          .padding(.top, 33)
        
        if viewStore.isLoading {
          Spacer()
          ProgressView()
          Spacer()
        } else {
          bookmarkMovieListView(viewStore: viewStore)
        }
      }
      .background(.black)
      .onFirstAppear {
        viewStore.send(.load)
      }
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

  private func bookmarkMovieListView(viewStore: ViewStoreType) -> some View {
    ScrollView(showsIndicators: false) {
      VStack(spacing: 20) {
        ForEach(viewStore.movies) { movie in
          NavigationLink {
            let store = Store(initialState: DetailFeature.State(movie: movie)) {
              DetailFeature()
            }
            DetailView(store: store)
          } label: {
            let store = Store(initialState: MovieThumbnailFeature.State(movie: movie)) {
              MovieThumbnailFeature()
            }
            PortraitMovieThumbnailViewLarge(store: store)
              .onFirstAppear {
                if viewStore.isLastPage == false
                    && movie == viewStore.movies.last {
                  viewStore.send(.loadMore)
                }
              }
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 30)
    }
    .refreshable {
      viewStore.send(.load)
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
