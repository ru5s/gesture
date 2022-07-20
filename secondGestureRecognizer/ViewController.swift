//
//  ViewController.swift
//  secondGestureRecognizer
//
//  Created by Ruslan Ismailov on 15/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var orangeView: UIView!
    
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mixingGesture = MixGesture(target: self, action: #selector(handleMixing))
        mixingGesture.delegate = self
        greenView.addGestureRecognizer(mixingGesture)
        
    }
    
    @objc func handleMixing(_ gesture: MixGesture){
        let redViewX = redView.frame.minX
        let redViewY = redView.frame.minY
        let redViewWidth = redView.frame.width
        let redViewHeight = redView.frame.height
        print("eeeef")
        redView.frame = CGRect(x: redViewX, y: redViewY, width: redViewWidth - 10, height: redViewHeight)
        
    }
    
    @IBAction func orangeViewTapGesture(_ sender: UITapGestureRecognizer) {
        if greenView.isHidden && redView.isHidden {
            greenView.isHidden = false
            redView.isHidden = false
            greenView.frame.origin = CGPoint(x: 150, y: 400)
            redView.frame.origin = CGPoint(x: 150, y: 600)
        }
        
    }
    @IBAction func greenPanAction(_ sender: UIPanGestureRecognizer) {
        let greenViewFrame = greenView.frame
        let orangeViewFrame = orangeView.frame
        
        let gestureTranslation = sender.translation(in: view)
        
        guard let gestureView = sender.view else {return}
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        sender.setTranslation(.zero, in: view)
        guard sender.state == .ended else {return}
        
//        print("green was panned")

        
        for value in Int(orangeViewFrame.minY)...Int(orangeViewFrame.maxY){
            if Int(greenViewFrame.origin.y) == value {
                greenView.isHidden = true
                
            }
        }
    }
    
    @IBAction func panAction(_ sender: UIPanGestureRecognizer) {
        let redViewFrame = redView.frame
        let orangeViewFrame = orangeView.frame
        
        let gestureTranslation = sender.translation(in: view)
        
        guard let gestureView = sender.view else {return}
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + gestureTranslation.x,
            y: gestureView.center.y + gestureTranslation.y)
        
        sender.setTranslation(.zero, in: view)
        guard sender.state == .ended else {return}
        
//        print("red was panned")
        
        for value in Int(orangeViewFrame.minY)...Int(orangeViewFrame.maxY){
            if Int(redViewFrame.origin.y) == value{
                redView.isHidden = true
            }
        }
    }
   
}

extension ViewController: UIGestureRecognizerDelegate{
    
}
