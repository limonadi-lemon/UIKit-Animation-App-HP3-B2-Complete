//
//  ViewController.swift
//  AnimationApp
//
//  Created by Tony Pham on 25/8/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    var imgIndex: Int = 1
    var timer: Timer!
    var isAnimating = false
    var audioPlayer : AVAudioPlayer?
    var audioName : String = "Auld Lang Syne - DJ Williams"
    var audioType : String = "mp3"
    func setupBackgroundMusic(){
        guard let path = Bundle.main.path(forResource: audioName, ofType: audioType) else {
            print("Không tìm thấy file âm thanh")
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: audioType)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            
        } catch {
            print("Lỗi \(error.localizedDescription)")
        }
    }
    func audioStart(){
        audioPlayer?.play()
    }
    func audioStop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
    func audioPause(){
        audioPlayer?.pause()
    
    }
    // MARK: - Outlets
    @IBOutlet weak var imgGoodnight: UIImageView!
    @IBOutlet weak var btnToggleAnimation: UIButton!
    @IBOutlet weak var btnResetAnimation: UIButton!
    
    @IBAction func changeToNextImage(_ sender: UIButton) {
        if (imgIndex >= 37) {
            imgIndex = 1
        } else {
            imgIndex += 1
        }
        updateImage()
    }
    
    // MARK: - Actions
    @IBAction func toggleAnimating(_ sender: UIButton) {
        
        if (isAnimating) {
            isAnimating = false
            btnToggleAnimation.tintColor = .systemBlue
            btnToggleAnimation.setTitle("Animate", for: .normal)
            pauseAnimation()
            btnResetAnimation.isHidden = true
        } else {
            isAnimating = true
            btnToggleAnimation.tintColor = .systemRed
            btnToggleAnimation.setTitle("Pause", for: .normal)
            startAnimation()
            btnResetAnimation.isHidden = false
        }
    }
    
    @IBAction func resetAnimation() {
        pauseAnimation()
        imgIndex = 1
        updateImage()
        toggleAnimating(btnToggleAnimation)
        audioStop()
    }
    
    // MARK: - Helper Methods
    func updateImage() {
        print("goodnight-images/goodnight\(imgIndex)")
        imgGoodnight.image = UIImage(named: "goodnight-images/goodnight\(imgIndex)")
    }
    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.changeToNextImage(_:)), userInfo: nil, repeats: true)
//    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.changeToNextImage(self.btnToggleAnimation)
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func startAnimation() {
        startTimer()
        audioStart()
    }
    
    func pauseAnimation() {
        stopTimer()
        audioPause()
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgIndex = 1
        updateImage()
        setupBackgroundMusic()
    }

}

