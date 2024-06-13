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
    var playPauseButton: UIButton!
    var progressBar: UIProgressView!
    var playerObserver: Any?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?

       override init(frame: CGRect) {
           super.init(frame: frame)
           setupVideoPlayerView()
           setupPlayPauseButton()
           setUpProgressView()
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
           setupVideoPlayerView()
           setupPlayPauseButton()
           setUpProgressView()
       }

       private func setupVideoPlayerView() {
           videoPlayerView = UIView(frame: self.contentView.bounds)
           videoPlayerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.contentView.addSubview(videoPlayerView)
       }
    
    private func setupPlayPauseButton() {
           playPauseButton = UIButton(type: .system)
           playPauseButton.translatesAutoresizingMaskIntoConstraints = false
           playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
           playPauseButton.tintColor = .white
           playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
           self.contentView.addSubview(playPauseButton)

           NSLayoutConstraint.activate([
               playPauseButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
               playPauseButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
               playPauseButton.widthAnchor.constraint(equalToConstant: 100),
               playPauseButton.heightAnchor.constraint(equalToConstant: 100)
           ])
       }
    
    private func setUpProgressView() {
           progressBar = UIProgressView(progressViewStyle: .default)
           progressBar.translatesAutoresizingMaskIntoConstraints = false
           self.contentView.addSubview(progressBar)

           NSLayoutConstraint.activate([
               progressBar.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
               progressBar.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
               progressBar.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -7),
               progressBar.heightAnchor.constraint(equalToConstant: 7)
           ])
       }

    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
        progressBar.progress = 0

        if let observer = playerObserver {
            player?.removeTimeObserver(observer)
            playerObserver = nil
        }
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
           setupProgressObserver()
       }
    

       override func layoutSubviews() {
           super.layoutSubviews()
           playerLayer?.frame = videoPlayerView.bounds
       }
    
    @objc func playPauseTapped() {
           if player?.rate == 0 {
               playVideo()
               playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
           } else {
               pauseVideo()
               playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
           }
       }
    
    func playVideo() {
            player?.play()
        
        }

        func pauseVideo() {
            player?.pause()
          
        }
    
    private func setupProgressObserver() {
            guard let player = player else { return }

            playerObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
                guard let self = self else { return }
                let duration = player.currentItem?.duration.seconds ?? 0
                let currentTime = player.currentTime().seconds
                self.progressBar.progress = Float(currentTime / duration)
            }
        }
}
