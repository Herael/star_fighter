//
//  StarshipListViewController.swift
//  StarFighter
//
//  Created by Arthur BLANC on 18/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit

class StarshipListViewController: UIViewController {
    public static let StarshipListViewController = "rtvc"
     
     @IBOutlet var starshipTableView: UITableView!
    public static var starshipCellId = "STARSHIP_ID"
     var spaceships: [Spaceship] = [] {
         didSet {
             self.starshipTableView.reloadData()
         }
     }
     var spaceshipService: SpaceshipService {
         return SpaceshipMockService()
         //return RestaurantAPIService()
     }
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.starshipTableView.dataSource = self
         self.starshipTableView.delegate = self
         self.starshipTableView.rowHeight = 120
        self.starshipTableView.register(UINib(nibName: "StarshipTableViewCell", bundle: nil), forCellReuseIdentifier:"STARSHIP_ID")
        print("yayay")
         
         /*self.navigationItem.rightBarButtonItems = [
             UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchAddButton))
         ]*/
         
         
         // Uncomment the following line to preserve selection between presentations
         // self.clearsSelectionOnViewWillAppear = false

         // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         // self.navigationItem.rightBarButtonItem = self.editButtonItem
     }
     
     override func viewDidAppear(_ animated: Bool) {
         self.spaceshipService.getAll { (spaceships) in
             self.spaceships = spaceships
         }
     }
    
     
}

extension StarshipListViewController: UITableViewDelegate {
    
}

extension StarshipListViewController: UITableViewDataSource {
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spaceships.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        let cell = starshipTableView.dequeueReusableCell(withIdentifier:"STARSHIP_ID", for: indexPath) as! StarshipTableViewCell
        let spaceship = self.spaceships[indexPath.row]
        print("yoyoy")
        cell.starshipName.text = spaceship.name
        cell.damage.text = String(spaceship.damage)
        cell.starshipImage.image = nil // restore default image
        /*if let pictureURL = restaurant.pictureURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: pictureURL) {
                    DispatchQueue.main.sync {
                        cell.pictureImageView.image = UIImage(data: data)
                    }
                }
            }
        }*/
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
