//
//  ViewController.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 08/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let conn : APIConnect = APIConnect()
        conn.getMovieGenreList { list in
            for i in list.genres{
                print("id : \(i.id), genre: \(i.name)")
            }
        }
        // Do any additional setup after loading the view.
    }


}

