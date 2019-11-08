//
//  ResultAlertController.swift
//  MemoriaJuego
//
//  Created by Loren on 31/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//

import UIKit
class ResultAlertController: UIViewController{
    
    @IBOutlet var viewAlert: UIView!
    @IBOutlet weak var imageResults: UIImageView!
    @IBOutlet weak var ButtonNext: UIButton!
    @IBOutlet weak var ButtonExit: UIButton!
    
    public var parenViewController: SelectViewController = SelectViewController()
    
    public var actualLevel = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // ButtonNext.setTitle(textoButton, for: .normal)
        ButtonNext.setBackgroundImage(UIImage(named:"boton"), for: .normal)
        ButtonNext.setBackgroundImage(UIImage(named:"botonP"), for: .highlighted)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewAlert.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func buttonNextPulsed(_ sender: UIButton) {
        
        
        switch ButtonNext.title(for: .normal){
        case "try":
            print("se ha pulsado en intentar de nuevo")
            
            self.dismiss(animated: true,completion: {
                self.parenViewController.atras(level: self.actualLevel)
            })
            
            
        case "next":
            print("Siguiente nivel")
            self.dismiss(animated: true, completion: {
                self.actualLevel = self.actualLevel+1
                self.parenViewController.atras(level: self.actualLevel)
            })

        default:
            print("No hago nada con el boton")
            break
        }
    }
    @IBAction func buttonExitPulsed(_ sender: Any) {
        print("Voy a la pantalla principal")
        self.dismiss(animated: true, completion: {
        self.parenViewController.home()
        })
    }
    
    
}
