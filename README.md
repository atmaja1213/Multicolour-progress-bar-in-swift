MultiColorProgressBar is a simple  UIProgressView.Color of this progress bar can be changed as per the requirement and the progress can be paused in between.

## Usage

var  progress = MultiColorProgressView(frame: CGRect(x: 10, y: 200, width: 320, height: 20), progressCount: 180, colors: self.graphColors)

view.addSubview(progress)
//Loop is running 180 times as we are showing the progress for 3 mins.
for segment in 0 ..< 180 {
self.progress.setProgressAnimation(Float(segment))
}

## Author

Atmaja Sahoo, atmaja1213@gmail.com
