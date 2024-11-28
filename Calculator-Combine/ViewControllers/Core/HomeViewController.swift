//
//  HomeViewController.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class HomeViewController: UIViewController {
    
     // MARK: - Properties
    
    
     // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
     // MARK: - Helpers
    private func setUp(){
        //self
        view.backgroundColor = .red
    }
    
}
