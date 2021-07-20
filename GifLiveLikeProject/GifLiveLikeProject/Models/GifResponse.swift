//
//  GifResponse.swift
//  GitSearch
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import Foundation
import UIKit

struct GifResponse: Decodable {
    let gif: [Gif]

    enum CodingKeys: String, CodingKey {
        case gif = "data"
    }
}

struct Gif: Decodable {
    let title, bitly_gif_url: String
}

