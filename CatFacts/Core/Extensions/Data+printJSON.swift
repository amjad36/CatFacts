//
//  Data+printJSON.swift
//  CatFacts
//
//  Created by Amjad Khan on 11/04/25.
//

import Foundation

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
