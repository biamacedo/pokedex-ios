//
//  DetailViewController.swift
//  Pokedex
//
//  Created by BEATRIZ MACEDO on 10/1/15.
//  Copyright © 2015 Beatriz Macedo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ids: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var catchRate: UILabel!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var specialAttack: UILabel!
    @IBOutlet weak var specialDefense: UILabel!
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let nameLabel = self.name {
                print(detail.valueForKey("name")!.description)
                nameLabel.text = detail.valueForKey("name")!.description
            }
            if let idsLabel = self.ids {
                idsLabel.text = detail.valueForKey("pkdx_id")!.description + "/" + detail.valueForKey("national_id")!.description
            }
            if let hpLabel = self.hp {
                hpLabel.text = detail.valueForKey("hp")!.description
            }
            if let attackLabel = self.attack {
                attackLabel.text = detail.valueForKey("attack")!.description
            }
            if let defenseLabel = self.defense {
                defenseLabel.text = detail.valueForKey("defense")!.description
            }
            if let catchLabel = self.catchRate {
                catchLabel.text = detail.valueForKey("catch_rate")!.description
            }
            if let expLabel = self.exp {
                expLabel.text = detail.valueForKey("exp")!.description
            }
            if let speedLabel = self.speed {
                speedLabel.text = detail.valueForKey("speed")!.description
            }
            if let specialAttackLabel = self.specialAttack {
                specialAttackLabel.text = detail.valueForKey("sp_atk")!.description
            }
            if let specialDefenseLabel = self.specialDefense {
                specialDefenseLabel.text = detail.valueForKey("sp_def")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

