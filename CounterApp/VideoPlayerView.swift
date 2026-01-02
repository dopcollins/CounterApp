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

    func makeUIView(context: Context) -> PlayerUIView {
        return PlayerUIView(videoName: videoName)
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        // Handle video name changes here if needed
    }
}

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    private var queuePlayer: AVQueuePlayer?

    init(videoName: String) {
        super.init(frame: .zero)
        setupPlayer(videoName: videoName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayer(videoName: String) {
        // Find resource
        let extensions = ["mp4", "mov", "m4v"]
        guard let url = extensions.compactMap({ Bundle.main.url(forResource: videoName, withExtension: $0) }).first else {
            print("❌ Video file '\(videoName)' not found.")
            return
        }

        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)

        // Setup QueuePlayer for looping
        let player = AVQueuePlayer(playerItem: playerItem)
        player.isMuted = true
        self.queuePlayer = player

        // Use AVPlayerLooper for seamless looping
        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)

        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    // Cleanup is handled by the deinit of the class
}
