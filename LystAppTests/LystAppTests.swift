//
//  LystAppTests.swift
//  LystAppTests
//
//  Created by Courtney Langmeyer on 12/14/21.
//

import XCTest
@testable import LystApp

class LystProjectTests: XCTestCase {
    
    var dogBreedsStrings = [String]()
    var breeds = [DogModel]()
    
    override func setUp() {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "DogBreeds", ofType: "json"),
              let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8),
              let breeds = try? JSONDecoder().decode([DogModel].self, from: jsonData) else {
            fatalError("DogBreeds.json error parsing")
        }
        
        self.breeds = breeds
        
        breeds.forEach {self.dogBreedsStrings.append($0.name!)}
    }
    
    func testDogModel() {
        XCTAssertEqual(breeds[3].name, "Airedale Terrier")
        XCTAssertEqual(breeds[3].bredFor, "Badger, otter hunting")
        XCTAssertEqual(breeds[3].breedGroup, "Terrier")
        XCTAssertEqual(breeds[3].origin, "United Kingdom, England")
        XCTAssertEqual(breeds[3].temperament, "Outgoing, Friendly, Alert, Confident, Intelligent, Courageous")
        XCTAssertEqual(breeds[3].weight!.metric, "18 - 29")
    }

    func testInfoViewController() {
        let image = UIImage(named: "questionmark") ?? UIImage()
        let viewModel = ViewModel()
        let measurement = DogMeasurement(imperial: "23 - 56", metric: "12- 34")
        let dog = DogModel(id: 123, name: "Doggy", temperament: "Smelly, agressive", origin: "Antarctica", bredFor: "Fighting", breedGroup: "Hound", image: nil, weight: measurement, height: measurement, wikipediaURL: "https://en.wikipedia.org/wiki/Hamburger")
        let viewController = DogInformationViewController(dog: dog, dogImage: image, viewModel: viewModel)
        
        viewController.viewWillAppear(true)
        viewController.tableView.reloadData()
        
        XCTAssertEqual(viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.detailTextLabel?.text, "Smelly, agressive")
        XCTAssertEqual(viewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "Temperament:")
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 6)
        XCTAssertEqual(viewController.tableView.numberOfSections, 1)
    }
    
    func testViewModel() {
        let viewModel = ViewModel()
        
        viewModel.dogBreeds = self.dogBreedsStrings
        
        XCTAssertEqual(viewModel.dogInformationTitles.count, 6)
        XCTAssertEqual(viewModel.dogBreeds.count, 172)
        XCTAssertEqual(viewModel.getIndexPathOfSearch(searchString: "Bor"), IndexPath(item: 40, section: 0))
        XCTAssertEqual(viewModel.getIndexPathOfSearch(searchString: "Bri"), IndexPath(item: 47, section: 0))
        XCTAssertEqual(viewModel.getIndexPathOfSearch(searchString: "Xo"), IndexPath(item: 170, section: 0))
        XCTAssertEqual(viewModel.getIndexPathOfSearch(searchString: "Af"), IndexPath(item: 0, section: 0))
    }
}
