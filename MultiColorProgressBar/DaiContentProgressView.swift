//
//  DaiContentProgressView.swift
//  MyCustomMultiColorProgressBar
//
//  Created by Atamaja Sahoo on 12/04/23.
//

import UIKit
public struct DaiProgressBarConstants {
    
    struct Style {
        static let basePostion: Float = 0.0
        static let barProgressTime: TimeInterval = 1.8
        static let barVisibleHeight: CGFloat = 7
        static let visualizerHeight: CGFloat = 50.0
    }
}
class DaiContentProgressView: UIView {

    private var progressArray: [UIProgressView] = [UIProgressView]()
        private var graphColors: [UIColor]?
        private var graphCount: Int?
        private var graphFrame: CGRect?
        private var timeSecondAddValue = Float()
        private var progressValue = Float()
        private var timer: Timer?
        private var targetedValue = Float()
        private var width = Float()

        init(frame: CGRect, progressCount: Int, colors: [UIColor]) {
            super.init(frame: frame)
            self.graphFrame = frame
            self.graphCount = progressCount
            self.graphColors = colors
            createProgressGraph()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            createProgressGraph()
        }

        func createProgressGraph() {
            guard let count = self.graphCount,
                  let frame = graphFrame,
                  let colors = self.graphColors else { return }

            for index in 0 ..< count {
                var xPosition: Float = DaiProgressBarConstants.Style.basePostion
                if index == 0 {
                    xPosition = DaiProgressBarConstants.Style.basePostion
                } else {
                    xPosition = xPosition + self.width
                }
                self.width = self.width + Float(frame.size.width / CGFloat(count))

                let progressSegment = UIProgressView(frame: CGRect(
                    x: CGFloat(xPosition),
                    y: CGFloat(DaiProgressBarConstants.Style.basePostion),
                    width: frame.size.width / CGFloat(count),
                    height: frame.size.height))
                progressSegment.transform = CGAffineTransform(scaleX: 1.0, y: DaiProgressBarConstants.Style.barVisibleHeight)
                progressSegment.tintColor = colors[index]
                progressSegment.progressViewStyle = .bar
                progressArray.append(progressSegment)
                self.addSubview(progressSegment)
            }
        }

        func getAdColors(colors: [UIColor]) {
            guard let count = self.graphCount else { return }
            for index in 0 ..< count {
                progressArray[index].tintColor = colors[index]
            }
        }

        @objc func showProgress() {
            progressValue += timeSecondAddValue
            addProgress(progressValue)
            if progressValue >= targetedValue {
                timer?.invalidate()
                timer = nil
            }
        }

        func addProgress(_ value: Float) {
            var value = value
            value = value * Float(progressArray.count)
            for i in 0 ..< progressArray.count {
                let progress = progressArray[i]
                let nowProgressValue = value - Float(i)
                if nowProgressValue > 0 {
                    progress.setProgress(nowProgressValue, animated: true)
                } else {
                    progress.setProgress(DaiProgressBarConstants.Style.basePostion, animated: true)
                }
            }
        }

        func setProgressAnimation(_ value: Float) {
            timeSecondAddValue = 0.01 * 1
            targetedValue = value
            progressValue = DaiProgressBarConstants.Style.basePostion
            for i in 0 ..< progressArray.count {
                let progress = progressArray[i]
                progressValue += progress.progress
            }
            progressValue = progressValue / Float(progressArray.count)

            if timer == nil {
                if progressValue < targetedValue {
                    timer = Timer.scheduledTimer(timeInterval: DaiProgressBarConstants.Style.barProgressTime, target: self, selector: #selector(self.showProgress), userInfo: nil, repeats: true)
                }
            }
        }

    
    
    
    
    
    
    }
