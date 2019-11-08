//
//  ViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 17/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    }

    @IBAction func pulsado(_ sender: UIButton) {
        
        sender.setBackgroundImage(UIImage(named:"boton"), for: .normal)


        sender.setBackgroundImage(UIImage(named:"botonP"), for: .highlighted)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startPlay"){
            let playController = segue.destination as! PlayViewController
            playController.level = 1
        }
            
    }
    
    
}

