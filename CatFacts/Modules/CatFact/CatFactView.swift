//
//  CatFactView.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import SwiftUI

struct CatFactView: View {
    @StateObject var vm: CatFactViewModel = CatFactViewModel()
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                AsyncImage(url: URL(string: vm.imageUrl ??  "https://cdn2.thecatapi.com/images/iWyIaja-G.jpg")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image("cat_photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 200, height: 200)
                .border(Color.gray)
                
                Text(vm.fact ?? "No Facts")
                    .padding()
            }
            .padding()
            .task {
                async let catFactsResponse: () = vm.loadCatFacts()
                async let catImagesResponse: () =  vm.loadCatImages()
                
                _ = await (catFactsResponse, catImagesResponse)
                
                vm.showRandomCatImageAndFact()
            }
        }
        .onTapGesture {
            vm.showRandomCatImageAndFact()
        }
    }
}

#Preview {
    CatFactView()
}
