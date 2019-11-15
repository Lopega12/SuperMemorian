//
//  ResultAlertController.swift
//  MemoriaJuego
//
//  Created by Loren on 31/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//

import UIKit
/**Alerta personalizada para informar al jugador si ha acertado o ha fallado, dando la opcion en todo momento de salir a la pantalla principal del juego, reintentar el nivel o pasar al siguiente nivel.*/
class ResultAlertController: UIViewController{
    
    @IBOutlet var viewAlert: UIView!
    @IBOutlet weak var imageResults: UIImageView!
    @IBOutlet weak var ButtonNext: UIButton!
    @IBOutlet weak var ButtonExit: UIButton!
    /**Controlador de la pantalla de seleccion de imagenes, que es la vista padre de esta alerta, es decir, que se pinta sobre la pantalla de seleccion de imagenes.*/
    public var parenViewController: SelectViewController = SelectViewController()
    /**Valor por defecto del nivel acual del jugador en caso de que no se haya pasado.*/
    public var actualLevel = 1
    //NIVELES QUE TIENE EL JUEGO,AL LLEGAR, EL USUARIO HA TERMINADO EL JUEGO//
    var maxLevel = 8
    /**Variable para determinar si ha llegado al nivel maximo del juego al acertar todas las imagenes*/
   public var acertado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**Estilo de los botones tanto en ser pulsado como en normal.*/
        ButtonNext.setBackgroundImage(UIImage(named:"boton"), for: .normal)
        ButtonNext.setBackgroundImage(UIImage(named:"botonP"), for: .highlighted)
        ButtonExit.setBackgroundImage(UIImage(named:"boton"), for: .normal)
        ButtonExit.setBackgroundImage(UIImage(named:"botonP"), for: .highlighted)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /**Estilo de la vista a la hora de mostrarla*/
        viewAlert.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.clear
        /**En caso de que haya llegado al nivel maximo del juego, el boton de siguiente nivel o reintentar se oculta para obligar al
         jugador volver a la pantall prinicipal del juego.*/
        if(self.actualLevel >= maxLevel && acertado){
            self.ButtonNext.isHidden = true;
        }
    }
    
    /**Accion para el boton de siguiente nivel o reintentar. Esto es por que el mismo boton, dependiendo del texto que ponga, realiza una funcion distinta.*/
    @IBAction func buttonNextPulsed(_ sender: UIButton) {
        
        /**En caso de que el texto del boton sea try, se cierra esta alerta y se pasa a la pantalla de memorizar las imagenes en el mismo nivel
         que estaba. Por el contrario, si el texto del boton es next, entonces pasara la pantalla de memorizar las imagenes pasandole el siguiente nivel.*/
        switch ButtonNext.title(for: .normal){
        case "try":
            /**Dismiss, es para cerrar la alerta con una animacion y al terminar de cerrarse ejecutar acciones en el parametro completion*/
            self.dismiss(animated: true,completion: {
                self.parenViewController.atras(level: self.actualLevel)
            })
            
            
        case "next":
            
            self.dismiss(animated: true, completion: {
                self.actualLevel = self.actualLevel+1
                self.parenViewController.atras(level: self.actualLevel)
            })

        default:
            print("No hago nada con el boton")
            break
        }
    }
    /**Accion del boton exit, para volver a la pantalla principal del juego.*/
    @IBAction func buttonExitPulsed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
        self.parenViewController.home()
        })
    }
    
    
}
