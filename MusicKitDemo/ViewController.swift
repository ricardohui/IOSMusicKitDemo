//
//  ViewController.swift
//  MusicKitDemo
//
//  Created by Ricardo Hui on 24/4/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    
    @IBOutlet var imageView: UIImageView!
    
    var mediaPlayer = MPMusicPlayerController.systemMusicPlayer
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var playPauseButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let item = mediaPlayer.nowPlayingItem{
            if let albumImage = item.artwork?.image(at: CGSize(width: 500, height: 500)){
                imageView.image = albumImage
                if let title = item.title{
                    titleLabel.text = title
                }
            }
            
        }
        
        if mediaPlayer.playbackState == .playing{
            playPauseButton.setTitle("Pause", for: .normal)
        }else{
            playPauseButton.setTitle("Play", for: .normal)
        }
    }

    @IBAction func chooseTapped(_ sender: Any) {
        let mediaPickerVC = MPMediaPickerController(mediaTypes: .music)
        mediaPickerVC.allowsPickingMultipleItems = false
        mediaPickerVC.popoverPresentationController?.sourceView = view
        mediaPickerVC.delegate = self
        present(mediaPickerVC, animated: true, completion: nil)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        for item in mediaItemCollection.items{
            playItem(item: item)
        }
        mediaPicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func playPauseTapped(_ sender: Any) {
        
        
        if mediaPlayer.playbackState == .playing{
            mediaPlayer.pause()
            playPauseButton.setTitle("Play", for: .normal)
        }else{
            mediaPlayer.play()
            playPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func randomTapped(_ sender: Any) {
        if let songs = MPMediaQuery.songs().items{
            let randomIndex = arc4random_uniform(UInt32(songs.count - 1))
            let item  = songs[Int(randomIndex)]
            playItem(item: item)
        }
        
    }
    
    func playItem(item: MPMediaItem){
        
            if let albumImage = item.artwork?.image(at: CGSize(width: 500, height: 500)){
                imageView.image = albumImage
                if let title = item.title{
                    titleLabel.text = title
                }
            }
        mediaPlayer.setQueue(with: MPMediaItemCollection(items:[item]))
        
        
        mediaPlayer.play()
        
    }
}

