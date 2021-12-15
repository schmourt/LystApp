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
    
    ///  Parse the dog model from web and populate array of breed names
    /// - Parameter completion: array of dog model objects
    func getBreedList(completion: @escaping ([DogModel])->()) {
        animalInterface.getBreedsList { [weak self] dogs in
            dogs.forEach {self?.dogBreeds.append($0.name ?? "N/A")}
            completion(dogs)
        }
    }
    
    /// Get dog image from url
    /// - Parameters:
    ///   - dog: dog object
    ///   - completion: image downloaded from url
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
    
    /// Get index path of the dog we searched
    /// - Parameter searchString: the substring from search bar
    /// - Returns: index path of the searched for dog
    func getIndexPathOfSearch(searchString: String) -> IndexPath {
        let index = dogBreeds.firstIndex { $0.lowercased().contains(searchString.lowercased()) } ?? 0

        return IndexPath(item: index, section: 0)
    }
    
    /// Get the array to populate the tableview cells
    /// - Parameter dog: dog model object
    /// - Returns: array of dog object strings
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
