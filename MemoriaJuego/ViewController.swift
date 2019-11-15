//
//  ViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 17/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//

import UIKit
/**
 Controlador del segue principal del juego.
 */
class ViewController: UIViewController {
    //Boton para empezar de jugar
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
    }
    
//Modificacion del fondo del boton cuando este pulsado y cuando no lo esté//
    @IBAction func pulsado(_ sender: UIButton) {
        
        sender.setBackgroundImage(UIImage(named:"boton"), for: .normal)


        sender.setBackgroundImage(UIImage(named:"botonP"), for: .highlighted)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "startPlay"){
            let playController = segue.destination as! PlayViewController
            /**
                            Arrancar el juego al nivel 1, pasandolo a la pantalla de mostrar las imagenes
             */
            playController.level = 1
        }
            
    }
    
    
}

