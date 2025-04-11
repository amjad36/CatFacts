//
//  CatFactViewModel.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import SwiftUI

final class CatFactViewModel: ObservableObject {
    @Published var imageUrl: String?
    @Published var fact: String?
    
    var images: [CatImagesResponse]?
    var facts: CatFactsResponse?
    
    private let limit: Int = 10
    
    init() { }
    
    func loadCatImages() async {
        do {
            images = try await HttpUtility.shared.loadData(for: "https://api.thecatapi.com/v1/images/search?limit=\(limit)&breed_ids=beng&api_key=REPLACE_ME")
        } catch {
            print("Unable to load pictures")
        }
    }
    
    func loadCatFacts() async {
        do {
            facts = try await HttpUtility.shared.loadData(for: "https://meowfacts.herokuapp.com/?count=\(limit)")
        } catch {
            print("Unable to load cat's facts")
        }
    }
    
    func showRandomCatImageAndFact() {
        let randomNumber = Int.random(in: 0..<limit)
        imageUrl = images?[randomNumber].url
        fact = facts?.data[randomNumber]
    }
}
