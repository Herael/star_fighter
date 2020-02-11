//
//  SpaceshipAPIService.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 01/02/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import Foundation
import Alamofire


class SpaceshipAPIService: SpaceshipService {
    
    let imageCache = NSCache<NSString, UIImage>()

    private let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    
    func downloadImage(urlString: String, image:UIImage){
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = image.pngData()
        try? data?.write(to : url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }

    func create(name: String, completion: @escaping (Bool) -> Void) {
        //todo
    }
    
    func getAll(completion: @escaping ([Spaceship]) -> Void) {
        var spaceshipsResponse:[Spaceship] = []
       
        Alamofire.request("https://mysterious-fortress-67328.herokuapp.com/spaceship/getAll", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            guard let json_response = response.value as? [String: Any],
                    let spaceships = json_response["spaceships"] as? [[String: Any]] else{
                        return
                    }
            
            for s in spaceships {
                guard let id = s["_id"] as? String,
                    let name = s["name"] as? String,
                    let model = s["model"] as? String,
                    let manufacturer = s["manufacturer"] as? String,
                    let speed = s["speed"] as? Int,
                    let hp = s["hp"] as? Int,
                    let damage = s["damage"] as? Int,
                    let spaceshipClass = s["spaceshipClass"] as? String,
                    let img = s["img"] as? String else {
                        print("error on /getAll")
                        return
                }
                
                spaceshipsResponse.append(Spaceship(id: id, name: name, model: model, manufacturer: manufacturer, speed: speed, hp: hp, damage: damage, spaceshipClass: spaceshipClass, img: URL(string: img)))
                
            }
            
            completion(spaceshipsResponse)
        }
    }
    
    func getById(_ id: String, completion: @escaping (Spaceship?) -> Void) {
        
        let params:[String:Any] = [
            "_id": id
        ]
        
        Alamofire.request("https://mysterious-fortress-67328.herokuapp.com/spaceship/getById", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            guard let json_response = response.value as? [String: Any],
                    let spaceships = json_response["spaceships"] as? [[String: Any]] else{
                        return
                    }
                guard let id = spaceships[0]["_id"] as? String,
                    let name = spaceships[0]["name"] as? String,
                    let model = spaceships[0]["model"] as? String,
                    let manufacturer = spaceships[0]["manufacturer"] as? String,
                    let speed = spaceships[0]["speed"] as? Int,
                    let hp = spaceships[0]["hp"] as? Int,
                    let damage = spaceships[0]["damage"] as? Int,
                    let spaceshipClass = spaceships[0]["spaceshipClass"] as? String,
                    let img = spaceships[0]["img"] as? String else {
                        print("error on /getById")
                        return
                }
                completion(Spaceship(id: id, name: name, model: model, manufacturer: manufacturer, speed: speed, hp: hp, damage: damage, spaceshipClass: spaceshipClass, img: URL(string: img)))
        }
    }
    
    func getRandom(completion: @escaping (Spaceship?) -> Void) {
        Alamofire.request("https://mysterious-fortress-67328.herokuapp.com/spaceship/getRandom", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            
            guard let json_response = response.value as? [String: Any],
                    let spaceships = json_response["spaceships"] as? [[String: Any]] else{
                        return
                    }
            guard let id = spaceships[0]["_id"] as? String,
                let name = spaceships[0]["name"] as? String,
                let model = spaceships[0]["model"] as? String,
                let manufacturer = spaceships[0]["manufacturer"] as? String,
                let speed = spaceships[0]["speed"] as? Int,
                let hp = spaceships[0]["hp"] as? Int,
                let damage = spaceships[0]["damage"] as? Int,
                let spaceshipClass = spaceships[0]["spaceshipClass"] as? String,
                let img = spaceships[0]["img"] as? String else {
                    print("error on /getRandom")
                    return
            }
            completion(Spaceship(id: id, name: name, model: model, manufacturer: manufacturer, speed: speed, hp: hp, damage: damage, spaceshipClass: spaceshipClass, img: URL(string: img)))
        }
    }
    
    func getXWing(completion: @escaping (Spaceship?) -> Void) {
        let params:[String:Any] = [
                "name": "X-wing"
            ]
            
            Alamofire.request("https://mysterious-fortress-67328.herokuapp.com/spaceship/getByElement", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
                guard let json_response = response.value as? [String: Any],
                        let spaceships = json_response["spaceships"] as? [[String: Any]] else{
                            return
                        }
                    guard let id = spaceships[0]["_id"] as? String,
                        let name = spaceships[0]["name"] as? String,
                        let model = spaceships[0]["model"] as? String,
                        let manufacturer = spaceships[0]["manufacturer"] as? String,
                        let speed = spaceships[0]["speed"] as? Int,
                        let hp = spaceships[0]["hp"] as? Int,
                        let damage = spaceships[0]["damage"] as? Int,
                        let spaceshipClass = spaceships[0]["spaceshipClass"] as? String,
                        let img = spaceships[0]["img"] as? String else {
                            print("error on /getById")
                            return
                    }
                    completion(Spaceship(id: id, name: name, model: model, manufacturer: manufacturer, speed: speed, hp: hp, damage: damage, spaceshipClass: spaceshipClass, img: URL(string: img)))
            }
        }
}
