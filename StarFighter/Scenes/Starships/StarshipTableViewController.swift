//
//  StarshipTableViewController.swift
//  StarFighter
//
//  Created by Benjamin Rousval on 01/02/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit

class StarshipTableViewController: UITableViewController {
        
    @IBOutlet var starshipTableView: UITableView!
    public static let spaceshipCellId = "STARSHIP_ID"
    var spaceships: [Spaceship] = [] {
        didSet {
            self.starshipTableView.reloadData()
        }
    }
    var spaceshipService: SpaceshipService {
//        return SpaceshipMockService()
        return SpaceshipAPIService()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.starshipTableView.dataSource = self
        self.starshipTableView.delegate = self
        self.starshipTableView.rowHeight = 120
        self.starshipTableView.register(UINib(nibName: "StarshipTableViewCell", bundle: nil), forCellReuseIdentifier:StarshipTableViewController.spaceshipCellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.spaceshipService.getAll { (spaceships) in
            self.spaceships = spaceships
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spaceships.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = starshipTableView.dequeueReusableCell(withIdentifier:StarshipTableViewController.spaceshipCellId, for: indexPath) as! StarshipTableViewCell
        let spaceship = self.spaceships[indexPath.row]
        cell.starshipName.text = spaceship.name
        cell.damage.text = String(spaceship.damage)
        if let pictureURL = spaceship.img {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: pictureURL) {
                    DispatchQueue.main.sync {
                        cell.starshipImage.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spaceshipDetail = StarshipDetailViewController()
        spaceshipDetail.spaceshipSelected = self.spaceships[indexPath.row]
        self.navigationController?.pushViewController(spaceshipDetail, animated: true)
    }
}
