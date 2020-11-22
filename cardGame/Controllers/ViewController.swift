//
//  ViewController.swift
//  cardGame
//
//  Created by Juan Carro on 19/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets & Variables
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var instructionsView: UIView!
    @IBOutlet weak var xBtn: UIButton!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var explosionImage: UIImageView!
    @IBOutlet weak var instructionsTextView: UILabel!
    
    @IBOutlet weak var display: UIDisplayView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var textbox: UITextView!
    
    var arrayNumberNegative = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11]
    var arrayNumberPositive = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    var sum: Int = 0
    var lostB: Bool = false
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        leftBtn.layer.cornerRadius = leftBtn.frame.size.width / 2
        leftBtn.clipsToBounds = true
        
        rightBtn.layer.cornerRadius = rightBtn.frame.size.width / 2
        rightBtn.clipsToBounds = true
    }
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLabel = display.label
        instructionsView.isHidden = false
        gameOverView.isHidden = true
        explosionImage.isHidden = true
        
        
        //Números Negativos
        //Asigna un número aleatorio negativo y lo imprime en su correspondiente Label
        let randomNumberNegative = arrayNumberNegative.randomElement()
        leftBtn.setTitle(String(randomNumberNegative!), for: UIControl.State.normal)
        
        //Elimino la posición del array, para que no vuelva a aparecer en la partida
        for (i, v) in arrayNumberNegative.enumerated(){
            if (v == randomNumberNegative){
                arrayNumberNegative.remove(at: i)
            }
        }
        
        //Números Positivos
        let randomNumberPositive = arrayNumberPositive.randomElement()
        rightBtn.setTitle(String(randomNumberPositive!), for: UIControl.State.normal)
        
        for (i, v) in arrayNumberPositive.enumerated(){
            if (v == randomNumberPositive){
                arrayNumberPositive.remove(at: i)
            }
        }
    }
    
    // MARK: UI Functions
    
    //Buttons Action Logic
    @IBAction func btnAction (_ sender: UIButton){
        //Parseo a Int y almaceno el contenido de los 3 labels
        let countLabelNumber = Int(displayLabel.text!)
        let negativeLabelNumber = Int(leftBtn.titleLabel!.text!)!
        let positiveLabelNumber = Int(rightBtn.titleLabel!.text!)!
        
        //Switch para dividir el IBAction (Case 0 = Negativo / Case 1 = Positivo)
        switch sender.tag {

        //Negativos
        case 0:
            //Almaceno el cálculo de ambos números y lo muestro en el label de la bomba
            self.sum = countLabelNumber! + negativeLabelNumber
            
            addZerosToLabelNumber()
            
            //Compruebo si el array de números sigue teniendo contenido
            //Si aún no está vacío, recojo una posición aleatoria y la muestro en el label
            if (!arrayNumberNegative.isEmpty){
                let randomNumberNegative = arrayNumberNegative.randomElement()
                leftBtn.setTitle(String(randomNumberNegative!), for: .normal)
                
                for (i, v) in arrayNumberNegative.enumerated(){
                    if (v == randomNumberNegative){
                        arrayNumberNegative.remove(at: i)
                    }
                }
                //Si el array está vacío, le asigno el número 0, de manera que su interacción no tenga ningún efecto
            } else {
                leftBtn.setTitle("0", for: .normal)
            }
        
        //Positivos
        case 1:
            self.sum = countLabelNumber! + positiveLabelNumber
            
            addZerosToLabelNumber()
            
            if (!arrayNumberPositive.isEmpty){
                let randomNumberPositive = arrayNumberPositive.randomElement()
                rightBtn.setTitle(String(randomNumberPositive!), for: .normal)
                
                for (i,v) in arrayNumberPositive.enumerated(){
                    if (v == randomNumberPositive){
                        arrayNumberPositive.remove(at: i)
                    }
                }
            } else {
                rightBtn.setTitle("0", for: .normal)
            }
            
        default:
            displayLabel.text = "000"
        }
        
        changeLabelTextColor()
        gameOverState()

    }
    
    //Cambio el color del label de la bomba, según su proximidad al número 21
    func changeLabelTextColor(){
        if (Int(displayLabel.text!)! > 9 && Int(displayLabel.text!)! < 19){
            displayLabel.textColor = UIColor.yellow
        }else if (Int(displayLabel.text!)! > 18 && Int(displayLabel.text!)! < 21){
            displayLabel.textColor = UIColor.blue
        }else if (Int(displayLabel.text!)! == 21){
            displayLabel.textColor = UIColor.green
        }else {
            displayLabel.textColor = UIColor.red
        }
    }
    
    //Añade 0s al text del Label en función del número que haya
    func addZerosToLabelNumber(){
        if (sum > 9){
            displayLabel.text = "0" + String(sum)
        }else if(sum > -1 && sum < 10){
            displayLabel.text = "00" + String(sum)
        }else if(sum < 0){
            displayLabel.text = String(sum)
        }
    }
    
    //Lanza la función correspondiente, si has ganado o perdido
    func gameOverState(){
        if (displayLabel.text == "021"){
            winState()
        } else if (Int(displayLabel.text!)! < 0 || Int(displayLabel.text!)! > 21){
            lostState()
        }
    }
    
    //Botón instrucciones
    @IBAction func infoAction(_ sender: Any) {
        instructionsView.isHidden = false
    }
    
    //Cierra el panel de instrucciones
    @IBAction func xBtnAction(_ sender: Any) {
        instructionsView.isHidden = true;
    }
    
    //Cuando ganas la partida
    func winState(){
        leftBtn.isHidden = true
        rightBtn.isHidden = true
        infoBtn.isHidden = true
        
        display.bombAnimation()
        delayTime()
        
        textbox.text = "¡Felicidades! \n Lo has conseguido. \n \n ¿Te apetece desactivar otra? \n \n :)"
    }
    
    //Cuando pierdes la partida
    func lostState(){
        leftBtn.isHidden = true
        rightBtn.isHidden = true
        infoBtn.isHidden = true
        
        lostB = true
        
        display.bombAnimation()
        delayTime()
  
        textbox.text = "Un mal día lo tiene cualquiera. \n \n :)"
    }
    
    //Unos segundos de delay antes de mostrar el mensaje final
    func delayTime(){
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
            self.displayLabel.isHidden = true
            if(self.lostB){
                self.explosionImage.isHidden = false
            }
            self.gameOverView.isHidden = false
        }
    }
    

}

