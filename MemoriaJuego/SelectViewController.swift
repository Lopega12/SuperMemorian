//
//  SelectViewController.swift
//  MemoriaJuego
//
//  Created by Loren on 22/10/2019.
//  Copyright © 2019 Loren. All rights reserved.
//
/**
 Controlador para la pantalla de seleccionar 
 */
import UIKit

class SelectViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate{
    /*Array con las imagenes posibles que el jugador puede escoger**/
    var options = [String]()
    /*Por defecto pongo el nivel 0 para asegurarme de que no salta a un nivel superior o no muestre nada si hay algun error**/
    public var level = 0;
    public var checkOptions = [String]() //Coleccion de las imagenes mostradas en el segue anterior
    /**
        Declaracion del boton flotante.
     */
       var roundButton = UIButton()
    
    //CollectionView con las imagenes que puede escoger el jugador
    @IBOutlet weak var gridOptions: UICollectionView!
     //CollectionView con las imagenes selccionadas por el jugador
    @IBOutlet weak var gridSelected: UICollectionView!
    
    var imagesSelected = [String]() //Coleccion de las imagenes seleccionadas
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gridOptions {
             return options.count
        }else{
            return imagesSelected.count
        }
       
    }
    
/**      Sacar el nombre de la imagen a a partir de un array con los nombres de cada imagen, cada imagen ira en una posicion determinada del content view.
 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /**
         Distiguir que CollectionView es el seleccionado, una vez distinguido se accede al contenido de la celda para sacar la imagen,eliminar/añadir del la lista correspondiente y despues refrescar los dos collectionView todo ello accediendo al nombre de la imagen en la celda correspondiente.
         */
        if collectionView == gridOptions{
        
        let image = options[indexPath.row]
        let indentifierCell = "CellSel"
            
        let cell = self.gridOptions.dequeueReusableCell(withReuseIdentifier: indentifierCell , for: indexPath) as! OptionsCollectionCell
            
         cell.imagenCelda.image = UIImage.init(imageLiteralResourceName: image)
        return cell
            
        }else{
            
            let image = imagesSelected[indexPath.row]
                    let indentifierCell = "SelCell"
            
                    let cell = self.gridSelected.dequeueReusableCell(withReuseIdentifier: indentifierCell , for: indexPath) as! SelectedCollectionCell
        
            cell.SelImage.image = UIImage.init(imageLiteralResourceName: image)
            return cell
        }
        
    }
    
    /**
     Sacar la imagen del CollectionView con las opciones al CollectionView  de las imagenes elegidas por el jugador y viceversa
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == gridOptions){
            print(imagesSelected.count)
            if(imagesSelected.count < checkOptions.count && options.count > 0){
            
                let nameImage = options[indexPath.row]
                options.remove(at: indexPath.row)
                imagesSelected.append(nameImage)
                if (imagesSelected.count == checkOptions.count){
                    self.roundButton.isHidden = false
                }
                gridSelected.reloadData()
                gridOptions.reloadData()
                print("Images seleccionaas: ",imagesSelected.count)
                
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
    
    /**
     Segun el nivel enviado por la pantalla de ver las imagenes a memorizar, la lista con las imagenes que puede seleccionar el jugador, varía
     */
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
    
    /**Realiza el pintado del segue, se llama antes de viewDidLoad*/
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
      }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        /**
                    Opciones para el boton flotante como estilos,constraints,posicion,tamaño,fuente....
         */
        self.roundButton = UIButton(type: .custom)
        roundButton.isHidden = true
        self.roundButton.setTitleColor(UIColor.white, for: .normal)
        self.roundButton.addTarget(self, action: #selector(ButtonClick(_:)), for: UIControl.Event.touchUpInside)
        self.roundButton.setTitle("->", for: .normal)
        self.roundButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
        self.view.addSubview(roundButton)
        self.view.bringSubviewToFront(roundButton)
        
        
        checkLevel(level: level)
        /**Asignacion de las imagenes a los CollectionView y Permitir la seleccionMultiple de celdas*/
        gridOptions.dataSource = self
        gridOptions.delegate = self
        gridOptions.allowsMultipleSelection = true
        gridSelected.dataSource = self
        gridSelected.delegate = self
        
         
    }
    
    /**Pintado del boton por cada refresco de la pantalla*/
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
           roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
           roundButton.backgroundColor = UIColor.systemGreen
           roundButton.clipsToBounds = true
           //roundButton.setImage(UIImage(named:"your-image"), for: .normal)
           roundButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               roundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -3),
           roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
           roundButton.widthAnchor.constraint(equalToConstant: 80),
           roundButton.heightAnchor.constraint(equalToConstant: 80)])
        

       }
    /**Volver a la pantalla de ver las imagenes a memorizar, tanto para repetir el nivel como para avanzar al siguiente nivel*/
    public func atras(level: Int){
        self.level = level
        self.performSegue(withIdentifier: "replay2", sender: nil)
        
    }
    /**Volver a la pantalla principal del juego*/
    public func home(){
        self.performSegue(withIdentifier: "home", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "replay2"){
            let playController = segue.destination as! PlayViewController
            playController.level = self.level
            print("Nivel destino2: \(self.level)")
        }else if(segue.identifier == "home"){
            print("al menú principal del juego")
            _ = segue.destination as! ViewController
        }
            
    }
       /** Acciones del boton flotante **/

       @IBAction func ButtonClick(_ sender: UIButton){

        /** LLamar a la laerta personalizada**/
        let notesAlert = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alertView") as? ResultAlertController
            )!
        notesAlert.parenViewController = self
        /**Dependiendo de si el jugador a  acertado con el orden y la cantidad de las imagenes acertadas, mostrar una imagen y texto de los botones diferentes, en este caso solo sera el boton de reintentar y el boton de siguiente nivel. Además se le pasa el nivel actual a la alerta para avanzar o mantenerse el mismo nivel.*/
        if(checkCorrects(imagesLevel: checkOptions, imagesSelect: imagesSelected)){
            self.present(notesAlert, animated: true, completion: nil)
            notesAlert.ButtonNext.setTitle("next", for: .normal)
            notesAlert.imageResults.image = UIImage(named: "win")
            notesAlert.actualLevel = level
            /**Comprobacion adicional para ocultar el boton de siguiente.*/
            notesAlert.acertado = true;
        }else{
            self.present(notesAlert, animated: true, completion: nil)
            notesAlert.ButtonNext.setTitle("try", for: .normal)
            notesAlert.imageResults.image = UIImage(named: "lose")
            notesAlert.actualLevel = level
        }
             

       }
    /**Comprueba si las imagenes selccionadas por el jugador estan en la lista de imagenes a memorizar y esten en el mismo orden*/
    func checkCorrects(imagesLevel:[String],imagesSelect: [String])->Bool{
        for i in 0..<imagesLevel.count {
            if(imagesLevel[i] != imagesSelect[i]){
                return false
            }
        }
        return true;
    }
}
