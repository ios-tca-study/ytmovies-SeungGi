//
//  DiscoverView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture

struct DiscoverView: View {
  
  // MARK: - Properties
  
  @Bindable var store: StoreOf<DiscoverFeature>
  @Environment(\.dismiss) private var dismiss
  
  private var columns: [GridItem] = [
    GridItem(.adaptive(minimum: 160, maximum: 300), spacing: 15)
  ]
  
  
  // MARK: - Initializers
  
  init(store: StoreOf<DiscoverFeature>) {
    self.store = store
  }
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      navigationView()
        .padding(.top, 33)
      
      genreSelectorView()
        .frame(height: 50)
      
      if store.isLoading == true && store.page == 1 {
        Spacer()
        ProgressView()
        Spacer()
      } else {
        ScrollView {
          VStack {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
              ForEach(store.movies) { movie in
                let detailFeatureStore = Store(initialState: DetailFeature.State(movie: movie)) {
                  DetailFeature()
                }
                
                NavigationLink {
                  DetailView(store: detailFeatureStore)
                } label: {
                  let movieThumbnailFeatureStore = Store(initialState: MovieThumbnailFeature.State(movie: movie)) {
                    MovieThumbnailFeature()
                  }
                  PortraitMovieThumbnailView(store: movieThumbnailFeatureStore)
                    // 마지막 아이템이 처음 보여지는 시점에 데이터를 더 불러오도록 요청
                    .onFirstAppear {
                      if movie == store.state.movies.last {
                        store.send(.loadMore)
                      }
                    }
                }
              }
            }
            
            // 더 불러오기 로딩 뷰
            if !store.movies.isEmpty && store.isLoading {
              VStack {
                ProgressView()
              }
              .frame(height: 100)
            }
          }
          .padding(.horizontal, 16)
        }
        .padding(.top, 20)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
    .toolbarVisibility(.hidden, for: .navigationBar)
    .onFirstAppear {
      store.send(.search)
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
      
      LargeTitleText(title: "Discover")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }
  
  private func genreSelectorView() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(Genre.allCases, id: \.self) { genre in
          Button {
            store.send(.setGenre(genre))
          } label: {
            Text(genre.displayName)
              .font(.system(size: 14))
              .foregroundStyle(genre == store.state.genre ? .black : .white)
              .padding(.horizontal, 16)
              .padding(.vertical, 4)
              .background(genre == store.state.genre ? .accent : .gray70)
              .clipShape(Capsule())
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 10)
    }
  }
}


// MARK: - Preview

#if DEBUG
import Moya

struct DiscoverView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: DiscoverFeature.State()) { DiscoverFeature() }
    
    DiscoverView(store: store)
  }
}
#endif
