//
//  CatImagesResponse.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import Foundation

struct CatImagesResponse: Decodable {
    let id: String
    let url: String
    let width: Int?
    let height: Int?
}
