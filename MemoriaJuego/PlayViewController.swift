//
//  PlayViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 29/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//
 import UIKit
/**Controlador de la pantalla de visualizado de los elementos a memorizar*/
class PlayViewController: UIViewController {
    
    /**UIimage de la imagen a memorizar*/
    @IBOutlet weak var ActiveImage: UIImageView!
    
    /**Dejo por defecto el nivel a 0 en caso de que no se haya pasado el nivel desde alguna de las pantallas: Pantalla principal,Resultado del jugador*/
    public var level = 0
    
    var allImages = [String]()
    //Copia del array allImages, para enviar a la pantalla de seleccion de las imagenes.
    var toCompareResult = [String]()
    //nombre de la imagen actual mostrandose//
    var source = ""
    /**Tiempo para la funcion TImer por defecto para la presentacion de las imagenes a memorizar*/
    var delay = 1.0
   
    
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "selectOption"{
          let selectController = segue.destination as! SelectViewController
        selectController.level = level
        selectController.checkOptions = toCompareResult
      }
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      /**Dependiendo del nivel, mas imagenes tendra que memorizar el jugador con su tiempo de espera entre imagenes*/
        switch level {
        case 1:
           allImages = ["image1","image2","image3"]
           delay = 1.5
        case 2:
         allImages = ["image1","image2","image3","image4"]
         delay = 1
        case 3:
         allImages = ["image1","image2","image3","image4","image5"]
         delay = 0.5
        case 4:
            allImages = ["image1","image2","image3","image4","image5","image6"]
            delay = 0.5
        case 5:
            allImages = ["image1","image2","image3","image4","image5","image6","image7","image8"]
            delay = 1
       case 6:
            allImages = ["image1","image2","image3","image4","image5","image6","image7","image8","image9"]
            delay = 0.8
        case 7:
            allImages = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10"]
            delay = 0.7
        case 8:
            allImages = ["image1","image2","image3","image4","image5","image6","image7","image8","image9","image10","image11"]
            delay = 0.7
        default:
            break;
        }
        
        
        /**Para mostrar la imagene a memorizar a partir de la lista allImages, todo ello con un tiempo de espera dado que se repetira hasta que no quede ninguna imagen por mostrar, entonces pasará automaticamente a la siguiente pantalla.*/
        Timer.scheduledTimer(withTimeInterval: delay, repeats: true){timer in
            if(self.allImages.count == 0){
                timer.invalidate()
                self.performSegue(withIdentifier: "selectOption", sender: self)
                
            }else{
                /**Escoge la imagen a mostrar aleatoriamente,luego se añade a la lista toCompareResult para la siguiente pantalla.*/
                self.source = self.getPosRandom()
                self.toCompareResult.append(self.source);
                self.ActiveImage.image = UIImage.init(imageLiteralResourceName: self.source)
               
            }
        }
        
        
        
        }
   
   /**
     Sacar una imagen aleatoria sin repetir a partir de una lista ya definida
     */
    func getPosRandom()-> String{

            // Sacar una clave aleatoria del array
            let arrayKey = Int(arc4random_uniform(UInt32(allImages.count)))
           
           
            let randImage = allImages[arrayKey]
            
            //Eliminar el elemento del array para que no vuelva a repetirse
            allImages.remove(at: arrayKey)
        return randImage
    }
    
    /**Para evitar comportamientos extraños a la hora de pintar la pantalla*/
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
  
}


