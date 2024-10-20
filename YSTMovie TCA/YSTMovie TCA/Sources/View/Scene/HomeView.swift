//
//  HomeView.swift
//  YSTMovie TCA
//
//  Created by 이승기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
  
  // MARK: - Properties
  
  @Bindable var store: StoreOf<HomeFeature>
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      ScrollView {
        VStack(spacing: 30) {
          topFiveSection()
            .padding(.top, 33)
          
          latestSection()
        }
      }
      .background(Color.black)
      .onFirstAppear {
        store.send(.loadData)
      }
    } destination: { store in
      DiscoverView(store: store)
    }
  }
  
  private func topFiveSection() -> some View {
    VStack(spacing: 20) {
      LargeTitleText(title: "Top Five")
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
      
      if store.isLoading {
        VStack {
          ProgressView()
            .tint(.white)
        }
        .frame(height: 266)
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top, spacing: 20) {
            ForEach(store.topFiveMovies) { movie in
              let store = Store(initialState: DetailFeature.State(movie: movie)) {
                DetailFeature()
              }
              NavigationLink(destination: DetailView(store: store)) {
                let store = Store(initialState: MovieThumbnailFeature.State(movie: movie)) {
                  MovieThumbnailFeature()
                }
                LandscapeMovieThumbnailViewRegular(store: store)
              }
            }
          }
          .padding(.horizontal, 16)
        }
      }
    }
  }
  
  private func latestSection() -> some View {
    VStack(spacing: 20) {
      HStack(spacing: 0) {
        LargeTitleText(title: "Latest")
        
        Spacer()
        
        Button {
          
        } label: {
          if !store.isLoading {
            Text("SEE MORE")
              .font(.system(size: 16))
              .foregroundColor(.accentColor)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 16)
      
      if let latestMovie = store.latestMovie {
        if store.isLoading {
          VStack {
            ProgressView()
              .tint(.white)
          }
          .frame(height: 266)
        } else {
          let store = Store(initialState: DetailFeature.State(movie: latestMovie)) {
            DetailFeature()
          }
          NavigationLink(destination: DetailView(store: store)) {
            let store = Store(initialState: MovieThumbnailFeature.State(movie: latestMovie)) {
              MovieThumbnailFeature()
            }
            PortraitMovieThumbnailViewLarge(store: store)
            .padding(16)
          }
        }
      }
    }
  }
}

#if DEBUG
import Moya

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    let store = Store(initialState: HomeFeature.State()) { HomeFeature() }
    
    HomeView(store: store)
  }
}
#endif
