//
//  ViewModel.swift
//  LystApp
//
//

import Foundation
import UIKit

class ViewModel {
    let animalInterface = AnimalInterface()
    
    var dogBreeds = [String]()
    var dogInformationTitles = ["Temperament:", "Bred For:", "Breeding Group:", "Origin:", "Weight (kg):", "Height (cm):"]
    
    func getBreedList(completion: @escaping ([DogModel])->()) {
        animalInterface.getBreedsList { [weak self] dogs in
            dogs.forEach {self?.dogBreeds.append($0.name ?? "N/A")}
            completion(dogs)
        }
    }
    
    func getImage(dog: DogModel, completion: @escaping (UIImage)->()) {
        guard let image = dog.image,
              let urlString = image.url,
              let url = URL(string: urlString) else {
            return
        }
        
        animalInterface.getImage(url: url) { image in
            completion(image)
        }
    }
    
    func getIndexPathOfSearch(searchString: String) -> IndexPath {
        let index = dogBreeds.firstIndex { $0.lowercased().contains(searchString.lowercased()) } ?? 0

        return IndexPath(item: index, section: 0)
    }
    
    func getDogInformationArray(dog: DogModel) -> [String] {
        let defaultString = "N/A"
        
        let temperament = dog.temperament ?? defaultString
        let origin = dog.origin ?? defaultString
        let bredFor = dog.bredFor ?? defaultString
        let breedGroup = dog.breedGroup ?? defaultString
        let weight = dog.weight?.metric ?? defaultString
        let height = dog.height?.metric ?? defaultString
        
        return [temperament,
                bredFor,
                breedGroup,
                origin,
                weight,
                height]
    }
}
