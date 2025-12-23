//
//  VideoPlayerView.swift
//  CounterApp
//
//  Created by Collins Roy on 23/12/25.
//


import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    let videoName: String
    
    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(videoName: videoName)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class PlayerUIView: UIView {
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    
    init(videoName: String) {
        super.init(frame: .zero)
        
        // Try multiple extensions
        let extensions = ["mp4", "mov", "m4v", "MP4", "MOV"]
        var videoURL: URL?
        
        for ext in extensions {
            if let path = Bundle.main.path(forResource: videoName, ofType: ext) {
                videoURL = URL(fileURLWithPath: path)
                print("✅ Found video: \(videoName).\(ext)")
                break
            }
        }
        
        guard let url = videoURL else {
            print("❌ Video file '\(videoName)' not found in bundle")
            print("Available files:", Bundle.main.paths(forResourcesOfType: nil, inDirectory: nil))
            return
        }
        
        player = AVPlayer(url: url)
        player?.isMuted = true  // Mute the video
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer!)
        
        // Loop video
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
        
        player?.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    deinit {
        player?.pause()
        NotificationCenter.default.removeObserver(self)
    }
}
