//
//  MarsManager.swift
//  MarsPictures
//
//  Created by Alex Cannizzo on 14/09/2021.
//

import Foundation

protocol MarsManagerDelegate {
    func didRetrieveData(_ marsManager: MarsManager, mars: MarsModel)
    func didRetrieveWithError(error: Error)
}

struct MarsManager {
    
    var delegate: MarsManagerDelegate?
    
    func performRequest() {
        if let url = URL(string: Constants.API_URL) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil || data == nil {
                    self.delegate?.didRetrieveWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let mars = self.parseJSON(safeData) {
                        delegate?.didRetrieveData(self, mars: mars)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ marsData: Data) -> MarsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MarsData.self, from: marsData)
            let date = decodedData.date
            let description = decodedData.explanation
            let imageURL = decodedData.url
            let mars = MarsModel(date: date, explanation: description, imageURLasString: imageURL)
            return mars
        } catch {
            return nil
        }
    }
    
}
