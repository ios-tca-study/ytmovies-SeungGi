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
  
  @Bindable var store: StoreOf<SearchFeature>
  
  @Environment(\.dismiss) private var dismiss
  @FocusState private var isFocused
  
  // MARK: - Initializers
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      navigationView()
        .padding(.top, 33)
      
      textField()
        .padding(.horizontal, 16)
      
      if store.isLoading && store.page == 1 {
        Spacer()
        ProgressView()
        Spacer()
      } else {
        searchResult()
      }
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
          
          TextField("Search", text: $store.term.sending(\.termChanged))
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
  
  private func searchResult() -> some View {
    ScrollView(showsIndicators: false) {
      LazyVStack(spacing: 20) {
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
            
            PortraitMovieThumbnailViewLarge(store: movieThumbnailFeatureStore)
              .onFirstAppear {
                if movie == store.state.movies.last {
                  store.send(.loadMore)
                }
              }
          }
        }

        // 맨 마지막으로 스크롤 했을때 ProgressView onAppear 시점에
        // 더 불러오기
        if !store.movies.isEmpty && store.isLoading {
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
    let store = Store(initialState: SearchFeature.State()) { SearchFeature() }
    
    SearchView(store: store)
  }
}
#endif
