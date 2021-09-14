//
//  MarsModel.swift
//  MarsPictures
//
//  Created by Alex Cannizzo on 14/09/2021.
//

import Foundation

struct MarsModel {
    
    let date: String
    let explanation: String
    let imageURLasString: String
    
    var imageURL: URL {
        URL(string: imageURLasString)!
    }
    
}
