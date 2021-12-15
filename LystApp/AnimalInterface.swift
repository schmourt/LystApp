//
//  AnimalInterface.swift
//  LystProject
//
//

import UIKit

enum Animal: String {
    case cat, dog
}

class AnimalInterface {
    
    func getImage(url: URL, completion: @escaping (UIImage)->()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                fatalError("Error decoding image data \(error!)")
            }
            
            completion(image)
        }.resume()
    }

    
    func getBreedsList(completion: @escaping ([DogModel])->()) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let breeds = try? JSONDecoder().decode([DogModel].self, from: data) else {
                fatalError("Error decoding data")
            }
    
            completion(breeds)
            
        }.resume()
    }
}
