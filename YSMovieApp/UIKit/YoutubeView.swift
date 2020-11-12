//
//  YoutubeView.swift
//  MovieApp
//
//  Created by Hüseyin B. on 12.11.2020.
//  Copyright © 2020 BaganaHuseyin. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit

final class YouTubeView: UIViewRepresentable {
    typealias UIViewType = YouTubePlayerView
    @ObservedObject var playerState: YouTubeControlState
    init(playerState: YouTubeControlState) {
        self.playerState = playerState
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(playerState: playerState)
    }
    func makeUIView(context: Context) -> UIViewType {
        let playerVars = [
            "controls": "1",
            "playsinline": "1",
            "autohide": "0",
            "autoplay": "0",
            "fs": "1",
            "rel": "0",
            "loop": "0",
            "enablejsapi": "0",
            "showinfo":"0",
            "modestbranding": "1"
        ]
        let ytVideo = YouTubePlayerView()
        ytVideo.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        ytVideo.delegate = context.coordinator
        return ytVideo
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let videoID = playerState.videoID else { return }
        if !(playerState.executeCommand == .idle) && uiView.ready {
            switch playerState.executeCommand {
            case .loadNewVideo:
                playerState.executeCommand = .idle
                uiView.loadVideoID(videoID)
            case .play:
                playerState.executeCommand = .idle
                uiView.play()
            case .pause:
                playerState.executeCommand = .idle
                uiView.pause()
            case .forward:
                playerState.executeCommand = .idle
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) + 10, seekAhead: true)
                }
            case .backward:
                playerState.executeCommand = .idle
                uiView.getCurrentTime { (time) in
                    guard let time = time else {return}
                    uiView.seekTo(Float(time) - 10, seekAhead: true)
                }
            default:
                playerState.executeCommand = .idle
                print("\(playerState.executeCommand) not yet implemented")
            }
        } else if !uiView.ready {
            uiView.loadVideoID(videoID)
        }
    }
    class Coordinator: YouTubePlayerDelegate {
        @ObservedObject var playerState: YouTubeControlState
        init(playerState: YouTubeControlState) {
            self.playerState = playerState
        }
        func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
            switch playerState {
            case .Playing:
                self.playerState.videoState = .play
            case .Paused, .Buffering, .Unstarted:
                self.playerState.videoState = .pause
            case .Ended:
                self.playerState.videoState = .stop
            default:
                print("\(playerState) not implemented")
            }
        }
    }
}
// 1
enum playerCommandToExecute {
    case loadNewVideo
    case play
    case pause
    case forward
    case backward
    case stop
    case idle
}

// 2
class YouTubeControlState: ObservableObject {
    init(videoId:String) {
        self.videoID = videoId
        self.executeCommand = .loadNewVideo

    }
    // 3
    @Published var videoID: String?  = nil
    {
        // 4
        didSet {
            self.executeCommand = .loadNewVideo
        }
    }
  
    // 5
    @Published var videoState: playerCommandToExecute = .loadNewVideo
    
    // 6
    @Published var executeCommand: playerCommandToExecute = .idle
    
    // 7
    func playPauseButtonTapped() {
        if videoState == .play {
            pauseVideo()
        } else if videoState == .pause {
            playVideo()
        } else {
            print("Unknown player state, attempting playing")
            playVideo()
        }
    }
    
    // 8
    func playVideo() {
        executeCommand = .play
    }
    
    func pauseVideo() {
        executeCommand = .pause
    }
    
    func forward() {
        executeCommand = .forward
    }
    
    func backward() {
        executeCommand = .backward
    }
}
