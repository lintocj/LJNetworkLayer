//
//  ViewController.swift
//  NetworkLayer
//
//  Created by linto jacob on 15/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import UIKit
import LJNetworkLayer

class ViewController: UIViewController {
    
    @IBOutlet weak var imgAnimal: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presenter = UserViewModel(dataSource: self)
        presenter.getExample()
        presenter.postExample()
        
        LJ.loadImageUsingCache(imageFile: imgAnimal, withUrl: "https://www.pixelstalk.net/wp-content/uploads/2016/07/Peaceful-Images-HD.jpg") { result in
            switch result {

            case .success(_):
                print("Success")
            case .failure(let error):
                print(error.localizedDescription.description)
            }
        }
    }
}

extension ViewController: ViewProtocol {

    func displayUsers<T>(output: T) {
        print(output)
    }

    func displayError<T>(error: T) {
     print(error)
    }
}

