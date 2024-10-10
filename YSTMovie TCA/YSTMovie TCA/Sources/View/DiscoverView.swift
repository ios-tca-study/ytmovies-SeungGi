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
  
  let store: StoreOf<DiscoverFeature>
  typealias ViewStoreType = ViewStore<DiscoverFeature.State, DiscoverFeature.Action>
  
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
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack(spacing: 0) {
        navigationView()
          .padding(.top, 33)
        
        genreSelectorView(viewStore: viewStore)
          .frame(height: 50)
        
        if viewStore.isLoading == true && viewStore.page == 1 {
          Spacer()
          ProgressView()
          Spacer()
        } else {
          ScrollView {
            VStack {
              LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(viewStore.movies) { movie in
                  NavigationLink {
                    DetailView()
                  } label: {
                    PortraitMovieThumbnailView(movie: movie)
                    // 마지막 아이템이 처음 보여지는 시점에 데이터를 더 불러오도록 요청
                      .onFirstAppear {
                        if movie == viewStore.state.movies.last {
                          store.send(.loadMore)
                        }
                      }
                  }
                }
              }
              
              // 더 불러오기 로딩 뷰
              if !viewStore.movies.isEmpty && viewStore.isLoading {
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
      .onAppear {
        viewStore.send(.search)
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
      
      LargeTitleText(title: "Discover")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }
  
  private func genreSelectorView(viewStore: ViewStoreType) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(Genre.allCases, id: \.self) { genre in
          Button {
            store.send(.setGenre(genre))
          } label: {
            Text(genre.displayName)
              .font(.system(size: 14))
              .foregroundStyle(genre == viewStore.state.genre ? .black : .white)
              .padding(.horizontal, 16)
              .padding(.vertical, 4)
              .background(genre == viewStore.state.genre ? .accent : .gray70)
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
    let service = MoyaProvider<YTSAPI>()
    let repository = YTSMovieRepositoryImpl(service: service)
    let searchMovieUseCase = SearchMovieUseCase(repository: repository)
    
    let store = Store(initialState: DiscoverFeature.State()) {
      DiscoverFeature(searchMovieUseCase: searchMovieUseCase)
    }
    
    DiscoverView(store: store)
  }
}
#endif
