//
//  SpaceshipService.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import Foundation

protocol SpaceshipService {
    
    func create(name: String, completion: @escaping (Bool) -> Void)
    func getAll(completion: @escaping ([Spaceship]) -> Void)
    func getById(_ id: String, completion: @escaping (Spaceship?) -> Void)
    func getRandom(completion: @escaping (Spaceship?) -> Void)
    func getXWing(completion: @escaping (Spaceship?) -> Void)

}
