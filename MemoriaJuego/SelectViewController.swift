//
//  SelectViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 22/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//
import UIKit

class SelectViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{
    var options = [String]()
    public var level = 0;
    public var checkOptions = [String]() //Coleccion de las imagenes mostradas en el segue anterior
    /*Cosas para el boton flotante**/
       var roundButton = UIButton()
    
    @IBOutlet weak var gridOptions: UICollectionView!
    
    @IBOutlet weak var gridSelected: UICollectionView!
    
    var imagesSelected = [String]() //Coleccion de las imagenes seleccionadas
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gridOptions {
             return options.count
        }else{
            return imagesSelected.count
        }
       
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == gridOptions{
        
//        Sacar el nombre de la imagen a a partir de un array con los nombres de cada imagen, cada imagen ira en una posicion determinada del content view.
        let image = options[indexPath.row]
        let indentifierCell = "CellSel"
//        acceder a la clase asignada al contenido de la celda, este caso es solo una imagen.
        let cell = self.gridOptions.dequeueReusableCell(withReuseIdentifier: indentifierCell , for: indexPath) as! OptionsCollectionCell
//        Asignar la imagen a la celda a partir de un nombre
         cell.imagenCelda.image = UIImage.init(imageLiteralResourceName: image)
        return cell
            
        }else{
            
            let image = imagesSelected[indexPath.row]
                    let indentifierCell = "SelCell"
            //        acceder a la clase asignada al contenido de la celda, este caso es solo una imagen.
                    let cell = self.gridSelected.dequeueReusableCell(withReuseIdentifier: indentifierCell , for: indexPath) as! SelectedCollectionCell
            //        Asignar la imagen a la celda a partir de un nombre
            cell.SelImage.image = UIImage.init(imageLiteralResourceName: image)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == gridOptions){
            print(imagesSelected.count)
            if(imagesSelected.count < checkOptions.count && options.count > 0){
            
                let nameImage = options[indexPath.row]
                options.remove(at: indexPath.row)
                gridSelected.reloadData()
                
                imagesSelected.append(nameImage)
                gridOptions.reloadData()
                  print("Images seleccionaas: ",imagesSelected.count)
                if (imagesSelected.count == checkOptions.count){
                  
                    roundButton.isHidden = false
                }
                
                
                
            }else{
                print("No puedes seleccionar mas")
            }
        }else{
            let nameSelected = imagesSelected[indexPath.row]
            imagesSelected.remove(at: indexPath.row)
            roundButton.isHidden = true
            gridSelected.reloadData()
            
            options.append(nameSelected)
            gridOptions.reloadData()
        }
        
    }
    
    func checkLevel(level: Int){
        switch level {
         case 1:
            options = ["image1","image2","image3","image4"]
        case 2:
            options = ["image1","image2","image3","image4","image5"]
        case 3:
            options = ["image1","image2","image3","image4","image5","image6"]
        case 4:
            options = ["image1","image2","image3","image4","image5","image6","image7"]
        case 5:
            options = ["image1","image2","image3","image4","image5","image6","image7","image8"]
        default:
            break
        }
    }
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          print("Mostrado vista al grid")
      }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /**
                    Cosas para el boton flotante a la hora de mostrarse
         */
        self.roundButton = UIButton(type: .custom)
        self.roundButton.setTitleColor(UIColor.orange, for: .normal)
        self.roundButton.addTarget(self, action: #selector(ButtonClick(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(roundButton)
        
        checkLevel(level: level)
        gridOptions.dataSource = self
        gridOptions.delegate = self
        gridOptions.allowsMultipleSelection = true
        gridSelected.dataSource = self
        gridSelected.delegate = self
        
         /*playButton.backgroundColor = UIColor.clear*/
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {

           roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
           roundButton.backgroundColor = UIColor.lightGray
           roundButton.clipsToBounds = true
           //roundButton.setImage(UIImage(named:"your-image"), for: .normal)
           roundButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               roundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
           roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
           roundButton.widthAnchor.constraint(equalToConstant: 50),
           roundButton.heightAnchor.constraint(equalToConstant: 50)])
        roundButton.isHidden = true

       }
    public func atras(level: Int){
        self.level = level
        print("Nivel destino: \(self.level)")
        self.performSegue(withIdentifier: "replay2", sender: nil)
        
    }
    public func home(){
        print("entro al home")
        self.performSegue(withIdentifier: "home", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "replay2"){
            let playController = segue.destination as! PlayViewController
            playController.level = self.level
            print("Nivel destino2: \(self.level)")
        }else if(segue.identifier == "home"){
            print("al menú principal del juego")
            let homeController = segue.destination as! ViewController
        }
            
    }
       /** Action Handler for button **/

       @IBAction func ButtonClick(_ sender: UIButton){

        /** Do whatever you wanna do on button click**/
        let notesAlert = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertView") as? ResultAlertController
            )!
        notesAlert.parenViewController = self
        if(checkCorrects(imagesLevel: checkOptions, imagesSelect: imagesSelected)){
            self.present(notesAlert, animated: true, completion: nil)
            notesAlert.ButtonNext.setTitle("next", for: .normal)
            notesAlert.imageResults.image = UIImage(named: "win")
            notesAlert.actualLevel = level
        }else{
            self.present(notesAlert, animated: true, completion: nil)
            notesAlert.ButtonNext.setTitle("try", for: .normal)
            notesAlert.imageResults.image = UIImage(named: "lose")
            notesAlert.actualLevel = level
        }
             

       }
    
    func checkCorrects(imagesLevel:[String],imagesSelect: [String])->Bool{
        for i in 0..<imagesLevel.count {
            if(imagesLevel[i] != imagesSelect[i]){
                return false
            }
        }
        return true;
    }
}
