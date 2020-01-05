//
//  SpaceshipMockService.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import Foundation

class SpaceshipMockService: SpaceshipService {
    
    private let spaceships: [Spaceship] = [
        Spaceship(id: "1", name: "Executor", model: "Executor-class star dreadnought", manufacturer: "Kuat Drive Yards, Fondor Shipyards", speed: 40, hp: 600000, damage: 100000, spaceshipClass: "Star dreadnought" ,img: URL(string: "https://vignette.wikia.nocookie.net/spore/images/4/46/Executor-class_Star_Dreadnought.png/revision/latest/scale-to-width-down/1000?cb=20161018175227")),
        
        Spaceship(id: "2", name: "Sentinel-class landing craft", model: "Sentinel-class landing craft", manufacturer: "Sienar Fleet Systems, Cyngus Spaceworks", speed: 70, hp: 54000, damage: 8000, spaceshipClass: "landing craft", img: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/6/6e/Sentinel_negvv.png/revision/latest?cb=20170411232732"))
    ]
    
    func create(name: String, completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
    func getAll(completion: @escaping ([Spaceship]) -> Void) {
        completion(self.spaceships)
    }
    
    func getById(_ id: String, completion: @escaping (Spaceship?) -> Void) {
            completion(self.spaceships.first(where: { (s) -> Bool in
                return s.id == id
            }))
    }
    
    func getRandom(completion: @escaping (Spaceship?) -> Void) {
        return completion(self.spaceships[Int.random(in: 0 ..< self.spaceships.count)])
    }
    
    func getXWing(completion: @escaping (Spaceship?) -> Void) {
        return completion(Spaceship(id: "3", name: "X-wing", model: "T-65 X-wing", manufacturer: "Incom Corporation", speed: 100, hp: 1000000, damage: 24000, spaceshipClass: "Starfighter", img: URL(string: "https://vignette.wikia.nocookie.net/fr.starwars/images/e/eb/X-Wing_T-65.png/revision/latest?cb=20161005121139")))
    }
}
