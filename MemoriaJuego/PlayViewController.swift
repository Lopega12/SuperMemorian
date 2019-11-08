//
//  PlayViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 29/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//
 import UIKit
class PlayViewController: UIViewController {
    
    @IBOutlet weak var ActiveImage: UIImageView!
    
    public var level = 0
    
    var allImages = [String]()
    var toCompareResult = [String]() //Copia del array con los resultados de la
    var source = "" //Imagen actual mostrandose//
    var delay = 1.0
   
    
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "selectOption"{
        print(toCompareResult)
          let selectController = segue.destination as! SelectViewController
        //Continuo por aqui, pasar el nivel actual//
        selectController.level = level
        selectController.checkOptions = toCompareResult
      }
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Logica del juego debe de ir aqui//
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
            delay = 0.3
        case 5:
            allImages = ["image1","image2","image3","image4","image5","image6","image7","image8"]
            delay = 1
        default:
           print("no hago nada")
        }
        
        toCompareResult = allImages
        
        Timer.scheduledTimer(withTimeInterval: delay, repeats: true){timer in
            if(self.allImages.count == 0){
                timer.invalidate()
                self.performSegue(withIdentifier: "selectOption", sender: self)
                
            }else{
                self.source = self.getPosRandom()
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
            print(arrayKey)
           
            let randImage = allImages[arrayKey]
            print(randImage)
            //Eliminar el elemento del array para que no vuelva a repetirse
            allImages.remove(at: arrayKey)
        return randImage
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("M ostrado vista1")
        print("Nivel actual: \(level)")
    }
    
  
}


