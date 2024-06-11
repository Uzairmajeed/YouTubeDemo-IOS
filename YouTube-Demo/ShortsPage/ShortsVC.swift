//
//  ShortsVC.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 09/06/24.
//

import UIKit
import AVFoundation

class ShortsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    @IBOutlet var videoCollectionView: UICollectionView!
    
    let videoURLs: [URL] = [
        URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
        URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!,
        URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!,
        URL(string: "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")!,
        URL(string: "https://www.taxmann.com/emailer/images/CompaniesAct.mp4")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    func setupCollectionView() {
        videoCollectionView.dataSource = self
        videoCollectionView.delegate = self
        videoCollectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "VideoCollectionViewCell")
        
        if let layout = videoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 0
        }
        
        videoCollectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        let videoURL = videoURLs[indexPath.item]
        cell.configure(with: videoURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pauseAllVideosExceptVisible()
    }

    private func pauseAllVideosExceptVisible() {
        for case let cell as VideoCollectionViewCell in videoCollectionView.visibleCells {
            guard let indexPath = videoCollectionView.indexPath(for: cell), let player = cell.player else {
                continue
            }

            // Calculate the visible rect for the cell
            let visibleRect = CGRect(x: videoCollectionView.contentOffset.x, y: videoCollectionView.contentOffset.y, width: videoCollectionView.bounds.width, height: videoCollectionView.bounds.height)

            // Check if the cell is fully visible or partially visible
            if visibleRect.contains(cell.frame) {
                // Play the video if it's fully visible
                player.play()
            } else {
                // Pause the video if it's not fully visible
                player.pause()
            }
        }
    }

}

