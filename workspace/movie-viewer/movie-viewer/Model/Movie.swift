//
//  Movie.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 15/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    let movieId: String
    let advisoryRating: String
    let canonicalTitle: String
    let cast: [String]
    let genre: String
    let poster: String
    let posterLandscape: String
    let releaseDate: String
    let runtimeMins: String
    let synopsis: String
    let theater: String
}
