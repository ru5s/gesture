//
//  MixGesture.swift
//  secondGestureRecognizer
//
//  Created by Ruslan Ismailov on 15/07/22.
//

import UIKit

class MixGesture: UIGestureRecognizer {
    
    let requarimentMovements = 2
    let distanceForMixGesture: CGFloat = 35
    
    enum MixingGestureDirections{
        case left
        case right
        case undefind
    }
    
    var mixingNumber = 0
    var mixingStartPoint: CGPoint = .zero
    var finalDirection: MixingGestureDirections = .undefind
    
    override func reset() {
        mixingNumber = 0
        mixingStartPoint = .zero
        finalDirection = .undefind
        
        if state == .possible{
            state = .failed
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else {return}
        mixingStartPoint = touch.location(in: view)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else {return}
        let mixingLocation = touch.location(in: view)
        
        let horizontalDifference = mixingLocation.x - mixingStartPoint.x
        
        if abs(horizontalDifference) < CGFloat(distanceForMixGesture) {return}
        
        let direction: MixingGestureDirections
        
        if horizontalDifference < 0 {
            direction = .left
        } else{
            direction = .right
        }
        
        
        if finalDirection == .undefind || (finalDirection == .left && direction == .right) || (finalDirection == .right && direction == .left) {
            mixingStartPoint = mixingLocation
            finalDirection = direction
            mixingNumber = mixingNumber + 1
        }
        
        if state == .possible && mixingNumber > requarimentMovements {
            state = .ended
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }

}
