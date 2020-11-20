//
//  ViewController.swift
//  cardGame
//
//  Created by Juan Carro on 19/11/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: Outlets
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    // MARK: Number Arrays
    var arrayNumberNegative = [-1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11]
    var arrayNumberPositive = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        //Asigna un número aleatorio negativo y lo imprime en su correspondiente Label
        let randomNumberNegative = arrayNumberNegative.randomElement()
        leftLabel.text = String(randomNumberNegative!)
        
        //Elimino la posición del array, para que no vuelva a aparecer en la partida
        for (i, v) in arrayNumberNegative.enumerated(){
            if (v == randomNumberNegative){
                arrayNumberNegative.remove(at: i)
            }
        }
        
        //Lo mismo, pero con los números positivos
        let randomNumberPositive = arrayNumberPositive.randomElement()
        rightLabel.text = String(randomNumberPositive!)
        
        for (i, v) in arrayNumberPositive.enumerated(){
            if (v == randomNumberPositive){
                arrayNumberPositive.remove(at: i)
            }
        }
    }
    
    // MARK: UI Functions
    
    //Negative Number Button Logic
    @IBAction func leftBtnAction(_ sender: Any) {
            
        //Parseo a Int el .text del Label negativo y el del contador
        let countLabelNumber = Int(countLabel.text!)
        let leftLabelNumber = Int(leftLabel.text!)
        
        //Almaceno el cálculo de ambos números y lo muestro en .text del contador parseado a String
        let sum = countLabelNumber! + leftLabelNumber!
        countLabel.text = String(sum)
        
        //Compruebo si el array de números sigue teniendo contenido
        //Si aún no está vacío, recojo una posición aleatoria y la muestro en el label
        if (!arrayNumberNegative.isEmpty){
            let randomNumberNegative = arrayNumberNegative.randomElement()
            leftLabel.text = String(randomNumberNegative!)
            
            for (i, v) in arrayNumberNegative.enumerated(){
                if (v == randomNumberNegative){
                    arrayNumberNegative.remove(at: i)
                }
            }
            //Si el array está vacío, le asigno el número 0, de manera que su interacción no tenga ningún efecto
        } else {
            leftLabel.text = "0"
        }
    }
    
    //Positive Number Button Logic
    //Su explicación es la misma que en la anterior función
    @IBAction func rightBtnAction(_ sender: Any) {
        
        let countLabelNumber = Int(countLabel.text!)
        let rightLabelNumber = Int(rightLabel.text!)
        
        let sum = countLabelNumber! + rightLabelNumber!
        countLabel.text = String(sum)
        
        if (!arrayNumberPositive.isEmpty){
            let randomNumberPositive = arrayNumberPositive.randomElement()
            rightLabel.text = String(randomNumberPositive!)
            
            for (i,v) in arrayNumberPositive.enumerated(){
                if (v == randomNumberPositive){
                    arrayNumberPositive.remove(at: i)
                }
            }
        } else {
            rightLabel.text = "0"
        }
    }
}

