//
//  ViewController.swift
//  controlsPractics
//
//  Created by Nick on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var switches: [UISwitch]!
    
    var number = 128 {
        didSet {
            number = (number + 256) % 256
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        rotateSwitches()
    }
    
    func rotateSwitches() {
        for swit in switches {
            swit.layer.transform = CATransform3DMakeRotation(-.pi/2, 0, 0, 1)
        }
    }
    
    /// Updates Number From the Switches Set
    func updateNumberFromSwitches() {
        var number = 0
        
        for `switch` in switches {
            number += `switch`.isOn ? `switch`.tag : 0
        }
        self.number = number
    }
    
    /// Update Switches From the Number
    func updateSwitches() {
        for `switch` in switches {
            `switch`.isOn = Int(number) & `switch`.tag != 0
        }
    }
    
    /// Updates All outlets to current number
    func updateUI() {
        button.setTitle(String(number), for: [])
        updateSwitches()
        slider.value = Float(number)
        textField.text = String(number)
    }
    
    @IBAction func buttonPressed() {
        number += 1
    }
    
    @IBAction func sliderMoved() {
        number = Int(slider.value)
    }
    @IBAction func textEdited() {
        number = Int(textField.text ?? "") ?? 128
    }
    
    @IBAction func switchOn(_ sender: UISwitch) {
        updateNumberFromSwitches()
    }
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        
        if location.x < view.bounds.midX {
            number -= 1
        } else {
            number += 1
        }
    }
}

