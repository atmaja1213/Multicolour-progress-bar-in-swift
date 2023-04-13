//
//  ViewController.swift
//  MultiColorProgressBar
//
//  Created by Atamaja Sahoo on 12/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var graphColors: [UIColor] = [UIColor]()
    var progress: MultiColorProgressView?
    var progressBarStartTime:Float = 0.0
    var colorChangeTime:Float = 0.0
    var pauseTimeStart:Float = 0.0
    
    func getCurrentTime() -> Float {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let totalTime: Float = (3600.00 * (Float(hour)) + 60.00 * (Float(minutes)) + Float(seconds))
        return totalTime
        
    }
    
    override func viewDidLoad() {
        self.progressBarStartTime = getCurrentTime()
        for _ in 0 ..< 180 {
            self.graphColors.append(UIColor.systemBlue)
        }
        self.progress = MultiColorProgressView(frame: CGRect(x: 10, y: 200, width: 320, height: 20), progressCount: 180, colors: self.graphColors)
        
        view.addSubview(self.progress!)
        for segment in 0 ..< 180 {
            self.progress?.setProgressAnimation(Float(segment))
        }
    }
    
    @IBAction func resume(_ sender: Any) {
        self.progress?.setProgressAnimation(1.0)
    }
    
    @IBAction func changeColor(_ sender: Any) {
        self.colorChangeTime = getCurrentTime()
        var colourChangeSegment = Int(self.colorChangeTime - self.progressBarStartTime)
        // We are changing the color for 10 secs at a strech.
        let totalColorChangeSegment = colourChangeSegment + 10
        while colourChangeSegment < totalColorChangeSegment {
            self.graphColors[Int(colourChangeSegment)] = UIColor.orange
            colourChangeSegment = colourChangeSegment + 1
        }
        
        
        if let multiColorProgressView = self.progress {
            multiColorProgressView.getAdColors(colors: self.graphColors)
            multiColorProgressView.setProgressAnimation(1.0)
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        self.pauseTimeStart = getCurrentTime()
        let progressSegment = (self.pauseTimeStart - self.progressBarStartTime)
        self.progress?.setProgressAnimation(progressSegment *  0.0055)
    }
    
}


