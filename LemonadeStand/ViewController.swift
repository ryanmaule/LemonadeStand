//
//  ViewController.swift
//  LemonadeStand
//
//  Created by ryan on 2015-06-08.
//  Copyright (c) 2015 Ryan Maule. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let kStartingFunds = 10
    let kStartingLemons = 1
    let kStartingIceCubes = 1
    let kLemonPrice = 2
    let kIceCubePrice = 1
    
    var totalBalance = 0
    var totalLemons = 0
    var totalIceCubes = 0
    
    var buyingLemons = 0
    var buyingIceCubes = 0
    
    var usingLemons = 0
    var usingIceCubes = 0
    
    @IBOutlet weak var labelDollars: UILabel!
    @IBOutlet weak var labelLemons: UILabel!
    @IBOutlet weak var labelIceCubes: UILabel!
    @IBOutlet weak var labelBuyLemonsQuantity: UILabel!
    @IBOutlet weak var labelBuyIceCubesQuantity: UILabel!
    @IBOutlet weak var labelLemonsPrice: UILabel!
    @IBOutlet weak var labelIceCubesPrice: UILabel!
    @IBOutlet weak var labelUseLemonsQuantity: UILabel!
    @IBOutlet weak var labelUseIceCubesQuantity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDisplay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDisplay() {
        self.labelLemonsPrice.text = "$\(self.kLemonPrice)"
        self.labelIceCubesPrice.text = "$\(self.kIceCubePrice)"
        self.totalBalance = self.kStartingFunds
        self.totalLemons = self.kStartingLemons
        self.totalIceCubes = self.kStartingIceCubes
        self.updateDisplay()
    }
    
    func updateDisplay() {
        self.labelDollars.text = "$\(self.totalBalance) Dollar" + (outputPlural(self.totalBalance))
        self.labelLemons.text = "\(self.totalLemons) Lemon" + (outputPlural(self.totalLemons))
        self.labelIceCubes.text = "\(self.totalIceCubes) Ice Cube" + (outputPlural(self.totalIceCubes))
        self.labelBuyLemonsQuantity.text = "\(self.buyingLemons)"
        self.labelBuyIceCubesQuantity.text = "\(self.buyingIceCubes)"
        self.labelUseLemonsQuantity.text = "\(self.usingLemons)"
        self.labelUseIceCubesQuantity.text = "\(self.usingIceCubes)"
    }
    
    func resetDay() {
        self.buyingLemons = 0
        self.buyingIceCubes = 0
        self.usingLemons = 0
        self.usingIceCubes = 0
        self.updateDisplay()
        
        if self.totalLemons == 0 && self.totalBalance < kLemonPrice {
            showAlertWithText(message: "Game Over: Can't afford Lemons")
        }
        else if self.totalIceCubes == 0 && self.totalBalance < kIceCubePrice {
            showAlertWithText(message: "Game Over: Can't afford Ice Cubes")
        }
    }
    
    func outputPlural(myAmount: Int) -> String {
        if myAmount > 1 || myAmount == 0 {
            return "s"
        }
        else {
            return ""
        }
    }
    
    func showAlertWithText(header: String = "Warning", message: String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func addBuyLemons(sender: UIButton) {
        if self.totalBalance >= self.kLemonPrice {
            self.totalBalance -= self.kLemonPrice
            self.buyingLemons++
            self.totalLemons++
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "Not enough funds to buy Lemons")
        }
    }
    
    @IBAction func subBuyLemons(sender: UIButton) {
        if self.totalLemons > 0 {
            self.totalBalance += self.kLemonPrice
            self.buyingLemons--
            self.totalLemons--
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're out of Lemons")
        }
    }
    
    @IBAction func addBuyIceCubes(sender: UIButton) {
        if self.totalBalance >= self.kIceCubePrice {
            self.totalBalance -= self.kIceCubePrice
            self.buyingIceCubes++
            self.totalIceCubes++
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "Not enough funds to buy Ice Cubes")
        }
    }
    
    @IBAction func subBuyIceCubes(sender: UIButton) {
        if self.totalIceCubes > 0 {
            self.totalBalance += self.kIceCubePrice
            self.buyingIceCubes--
            self.totalIceCubes--
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're out of Ice Cubes")
        }
    }
    
    @IBAction func addUseLemons(sender: UIButton) {
        if self.totalLemons > 0 {
            self.totalLemons--
            self.usingLemons++
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're out of Lemons")
        }
    }
    
    @IBAction func subUseLemons(sender: UIButton) {
        if self.usingLemons > 0 {
            self.totalLemons++
            self.usingLemons--
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're not using any Lemons")
        }
    }
    
    @IBAction func addUseIceCubes(sender: UIButton) {
        if self.totalIceCubes > 0 {
            self.totalIceCubes--
            self.usingIceCubes++
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're out of Ice Cubes")
        }
    }
    
    @IBAction func subUseIceCubes(sender: UIButton) {
        if self.usingIceCubes > 0 {
            self.totalIceCubes++
            self.usingIceCubes--
            self.updateDisplay()
        }
        else {
            showAlertWithText(message: "You're not using any Ice Cubes")
        }
    }
    
    @IBAction func startDay(sender: UIButton) {
        if self.usingLemons > 0 && self.usingIceCubes > 0 {
            var totalCustomers = Int(arc4random_uniform(UInt32(10)))
            var totalEarnings = 0
            
            // Check the weather
            var weatherSwitch = Int(arc4random_uniform(UInt32(3)))
            var weatherType = ""
            switch weatherSwitch {
            case 0:
                totalCustomers -= 3
                weatherType = "Cloudy"
            case 1:
                totalCustomers += 4
                weatherType = "Sunny"
            default:
                totalCustomers += 0
                weatherType = "Normal"
            }
            
            println("Total Customers: \(totalCustomers)")
            var recipeRatio = Double(usingLemons) / Double(usingIceCubes)
        
            for var customer = 0; customer < totalCustomers; customer++ {
                var customerPreference = 1.0/(Double(Int(arc4random_uniform(UInt32(10))))+1.0)
                println("Customer Preference: \(customerPreference)")
                println("Recipe Ratio: \(recipeRatio)")
                if customerPreference >= 0 && customerPreference <= 0.4 {
                    if recipeRatio > 1 {
                        println("Paid: Loves Acidic!")
                        totalEarnings++
                    }
                    else {
                        println("No Match: Loves Acidic")
                    }
                }
                else if customerPreference > 0.4 && customerPreference <= 0.6 {
                    if recipeRatio == 1 {
                        println("Paid: Loves Equal Parts!")
                        totalEarnings++
                    }
                    else {
                        println("No Match: Loves Equal Parts")
                    }
                }
                else if customerPreference > 0.6 && customerPreference <= 1.0 {
                    if recipeRatio < 1 {
                        println("Paid: Loves Diluted!")
                        totalEarnings++
                    }
                    else {
                        println("No Match: Loves Diluted")
                    }
                }
                else {
                    println("Error Occurred: Can't Prefer > 1")
                }
            }
            totalBalance += totalEarnings
            self.resetDay()
            
            showAlertWithText(header: "Today's Weather: \(weatherType)", message: "You had \(totalCustomers) customers and made $\(totalEarnings)")
        }
        else {
            showAlertWithText(message: "You must use both Lemons and Ice Cubes")
        }
    }

}

