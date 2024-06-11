//
//  VideoCollectionViewCell.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 10/06/24.
//

import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var videoPlayerView: UIView!
    
    @IBOutlet var playpauseButton: UIButton!
    
    var player: AVPlayer?
       var playerLayer: AVPlayerLayer?

       override init(frame: CGRect) {
           super.init(frame: frame)
           setupVideoPlayerView()
           setupPlayPauseButton()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupVideoPlayerView()
       }

       private func setupVideoPlayerView() {
           videoPlayerView = UIView(frame: self.contentView.bounds)
           videoPlayerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.contentView.addSubview(videoPlayerView)
       }
    
    private func setupPlayPauseButton() {
        playpauseButton = UIButton(type: .system)
        playpauseButton.setTitle("Play/Pause", for: .normal)
        // Set the default system images for the button
        playpauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playpauseButton.setImage(UIImage(systemName: "pause.fill"), for: .selected)// Use selected state for the pause icon
        playpauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        playpauseButton.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(playpauseButton)
        
            // Add constraints for the button (adjust constraints as needed)
            NSLayoutConstraint.activate([
                playpauseButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                playpauseButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
            ])
            
            // Bring the button to the front
            self.contentView.bringSubviewToFront(playpauseButton)
        }

       override func prepareForReuse() {
           super.prepareForReuse()
           player?.pause()
           playerLayer?.removeFromSuperlayer()
           player = nil
           playerLayer = nil
       }

       func configure(with url: URL) {
           player = AVPlayer(url: url)
           playerLayer = AVPlayerLayer(player: player)
           playerLayer?.frame = videoPlayerView.bounds
           playerLayer?.videoGravity = .resizeAspectFill

           if let playerLayer = playerLayer {
               videoPlayerView.layer.addSublayer(playerLayer)
           }

           player?.play()
       }
    

       override func layoutSubviews() {
           super.layoutSubviews()
           playerLayer?.frame = videoPlayerView.bounds
       }
    
    @objc func playPauseTapped() {
            if player?.rate == 0 {
                playVideo()
            } else {
                pauseVideo()
            }
        }
    
    func playVideo() {
            player?.play()
        
        }

        func pauseVideo() {
            player?.pause()
          
        }
   }
