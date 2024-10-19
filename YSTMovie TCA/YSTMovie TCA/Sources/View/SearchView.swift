//
//  SearchView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
  
  // MARK: - Properties
  
  let store: StoreOf<SearchFeature>
  typealias ViewStoreType = ViewStore<SearchFeature.State, SearchFeature.Action>
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var isFocused
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    WithViewStore(self.store, observe: { $0 }) { viewStore in
      VStack {
        navigationView()
          .padding(.top, 33)
        
        textField(viewStore: viewStore)
          .padding(.horizontal, 16)
        
        if viewStore.isLoading && viewStore.page == 1 {
          Spacer()
          ProgressView()
          Spacer()
        } else {
          searchResult(viewStore: viewStore)
        }
      }
      .background(.black)
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
      
      LargeTitleText(title: "Search")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.horizontal, 16)
  }
  
  private func textField(viewStore: ViewStoreType) -> some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(.gray70)
      .frame(maxWidth: .infinity, maxHeight: 70)
      .overlay {
        HStack(spacing: 16) {
          Image.search
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(.white)
          
          TextField("Search", text: viewStore.binding(get: \.term, send: SearchFeature.Action.termChanged))
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .focused($isFocused)
        }
        .padding(.horizontal, 16)
      }
      .onAppear {
        isFocused = true
      }
  }
  
  private func searchResult(viewStore: ViewStoreType) -> some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(spacing: 20) {
        ForEach(viewStore.movies) { movie in
          let store = Store(initialState: DetailFeature.State(movie: movie)) {
            DetailFeature()
          }
          
          NavigationLink {
            DetailView(store: store)
          } label: {
            PortraitMovieThumbnailViewLarge(movie: movie)
              .onFirstAppear {
                if movie == viewStore.state.movies.last {
                  viewStore.send(.loadMore)
                }
              }
          }
        }

        // 맨 마지막으로 스크롤 했을때 ProgressView onAppear 시점에
        // 더 불러오기
        if !viewStore.movies.isEmpty && viewStore.isLoading {
          VStack {
            ProgressView()
          }
          .frame(height: 100)
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 30)
    }
  }
}


// MARK: - Preview

#if DEBUG
import Moya

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    let service = MoyaProvider<YTSAPI>()
    let repository = YTSMovieRepositoryImpl(service: service)
    let searchMovieUseCase = SearchMovieUseCase(repository: repository)
    
    let store = Store(initialState: SearchFeature.State()) {
      SearchFeature(searchMovieUseCase: searchMovieUseCase)
    }
    
    SearchView(store: store)
  }
}
#endif
