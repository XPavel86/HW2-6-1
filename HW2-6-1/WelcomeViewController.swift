//
//  WelcomeViewController.swift
//  HW2-6
//
//  Created by Pavel Dolgopolov on 18.02.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var logOutButton: UIButton!
    
    var greetingText: String!
    
    private let gradient = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
           super.viewWillLayoutSubviews()
        // Обновляем градиент при изменении ориентации
        gradient.frame = view.bounds
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greetingLabel.text? = greetingText
        
        greetingLabel.textColor = .white
        logOutButton.tintColor = .white
 
        // наводим красоту, как в примере
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.systemCyan.cgColor, UIColor.systemPink.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
