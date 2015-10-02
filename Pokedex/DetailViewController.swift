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
    @IBOutlet weak var image: UIImageView!
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            //self.configureView()
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
            
            getImageFromSprite(detail.valueForKey("sprite")!.description)
            
        }
    }
    
    func getImageFromSprite(spriteUrl: String){
        
        let url = NSURL(string:"http://pokeapi.co\(spriteUrl)")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if error == nil {
                
                if let content = data {
                    
                    // New Thread
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        do {
                            
                            
                            let sprite =  try NSJSONSerialization.JSONObjectWithData(content, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            
                            if sprite.count > 0 {
                                
                                //print(sprite["image"])
                                self.retrieveImage(sprite["image"] as! String)
                                
                            }
                        } catch {
                            print("Data not available")
                        }
                    }
                }
            } else {
                print("Error: \(error)")
            }
        }
        
        task.resume()
        
    }
    
    func retrieveImage(imageUri: String){
        
        let apiPartToRemove = "/media/img/"
        let pokemonImgId = imageUri.stringByReplacingOccurrencesOfString(apiPartToRemove, withString: "")
        
        var documentsDirectory: String?
        
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            documentsDirectory = paths[0] as? String
            
            let savePath = documentsDirectory! + "/pokemon_\(pokemonImgId)"
            //print(savePath)
            
            // First checking ig image was cached
            if NSFileManager.defaultManager().fileExistsAtPath(savePath) {
                print("Used Image From Cache")
                if let pokemonImage = self.image {
                    pokemonImage.image = UIImage(named: savePath)
                }
            } else {
                
                print("Image Not on Cache, Retrieving From API")
                let resourceUri = NSURL(string: "http://pokeapi.co\(imageUri)")
                
                let session = NSURLSession.sharedSession()
                
                let task = session.dataTaskWithURL(resourceUri!) { (data, response, error) -> Void in
                    
                    if error == nil {
                        
                        if let pokemonImage = UIImage(data: data!) {
                            
                            // New Thread
                            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                                
                                // Showing photo retrieved
                                self.image.image = pokemonImage
                                
                                // Saving Photo
                                if paths.count > 0 {
                                    documentsDirectory = paths[0] as? String
                                    
                                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                                }
                            }
                        }
                        
                    } else {
                        print(error)
                    }
                    
                }
                task.resume()
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

