
import Foundation
import AVFoundation
import Firebase
import FirebaseFirestore
import Observation
import MediaPlayer

@Observable
class AudioEngine {
    
    init() {
        setupRemoteCommander()
        setupAudioSession()
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    
    var player: AVPlayer?
    var isPlaying: Bool = false
    var currentURL: String?
    var currentTime: Double? = 0
    var seconds: Double? = 0
    var progress: Double = 0
    var timeObserver: Any?
    var duration: Double = 0
    var currentLessonID: Int?
    var currentTitle: String = ""
    var currentCountry: String = ""
    
    
    func isTrackPlaying(url: String) -> Bool {
        
        return currentURL == url && isPlaying
        
        
    }
    
    func playPause(title: String, country: String, url: String?, lessonID: Int?) {
        
        guard let urlString = url, let url = URL(string: urlString) else { return }
        
        
        self.currentCountry = country
        self.currentTitle = title
        
        if currentURL != urlString {
            
            cleanUpObserver()
            player?.pause()
            currentLessonID = lessonID


        }
        
        
        
        let playerItem = AVPlayerItem(url: url)
        player =  AVPlayer(playerItem: playerItem)
        isPlaying = false
        progress = 0
        
        if isPlaying {
            
            player?.pause()
            isPlaying = false
        } else {
            
            player?.play()
            
            isPlaying = true
            setupTimeObserver()
            
        }
        
        updateNowPlaying(title: title, country: country)
        Task {
            await updateMetadataAsync(title: title, country: country)
        }
        
        
        
    }
    
    
    func skip(seconds: Double) {
        
        guard let player = player else { return }
        
        let currentTime = player.currentTime()
        let jump = CMTime(seconds: seconds, preferredTimescale: 1)
        let newTime = CMTimeAdd(currentTime, jump)
        
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
            guard let self = self else { return }
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            
            
        }
    }
    
    func down(seconds: Double) {
        
        guard let player = player else { return }
        let currentTime = player.currentTime()
        let jump = CMTime(seconds: seconds, preferredTimescale: 1)
        let newTime = CMTimeSubtract(currentTime, jump)
        player.seek(to: newTime, toleranceBefore: .zero, toleranceAfter: .zero) { [weak self] _ in
            guard let self = self else { return }
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            
        }
    }
    
    
    func stopPlayer() {
        progress = 0
        cleanUpObserver()
        currentTime = player?.currentTime().seconds
        guard let duration = player?.currentItem?.duration else { return  }
        seconds = CMTimeGetSeconds(duration)
        isPlaying = false
        player = nil
        currentURL = nil
        
    }
    
    private func setupTimeObserver() {
            cleanUpObserver()
            let interval = CMTime(seconds: 0.5, preferredTimescale: 600)
            timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
                guard let self = self,
                      let duration = self.player?.currentItem?.duration.seconds,
                      duration > 0, let currenTime = player?.currentTime().seconds, currenTime > 0 else { return }
                
                
                self.progress = time.seconds / duration
                if progress >= 1.0 {
                    isPlaying = false
                    
                }
            
            }
        }

        private func cleanUpObserver() {
            if let observer = timeObserver {
                player?.removeTimeObserver(observer)
                timeObserver = nil
            }
        }
    
        func updateNowPlaying(title: String, country: String)  {
            guard let player = player, let item = player.currentItem else { return }
        var nowPlayingInfo = [String: Any]()
            
            let duration = item.duration.seconds
            let currentTime = player.currentTime().seconds
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = "CoffeeBreak: \(country)"
            if !duration.isNaN && duration > 0 {
                nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
            }
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime.isNaN ? 0 : currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
            if let artwork = createArtWork(imageName: "cup.and.heat.waves.fill") {
                
                nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
            }
        
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
        
    }
    
    func updateMetadataAsync(title: String, country: String) async {
        
        await waitForReady()
        
        if let duration = player?.currentItem?.duration.seconds, duration > 0 {
            
            await MainActor.run {
                
                self.duration = duration
                self.currentTime = player?.currentTime().seconds ?? 0
                updateNowPlaying(title: title, country: country)
                
            }
            
        }
        
        
    }
    
    func waitForReady() async {
        
        while player?.currentItem?.status != .readyToPlay {
            
            try? await Task.sleep(for: .seconds(0.1))
        }
        
    }
    
    private func createArtWork(imageName: String) -> MPMediaItemArtwork? {
        
        guard let image = UIImage(systemName: imageName) ?? UIImage(systemName: "music.note") else { return nil }
        
        
        return MPMediaItemArtwork(boundsSize: image.size) { size in
            
            return image
            
        }
    }
    
    private func setupRemoteCommander() {
        
        let commander = MPRemoteCommandCenter.shared()
        commander.nextTrackCommand.isEnabled = false
        commander.previousTrackCommand.isEnabled = false
        commander.skipBackwardCommand.isEnabled = true
        commander.skipBackwardCommand.preferredIntervals = [15]
        commander.skipForwardCommand.isEnabled = true
        commander.skipForwardCommand.preferredIntervals = [15]
        
        
        commander.playCommand.addTarget { [weak self] _ in
            
            guard let self = self else { return .commandFailed }
            self.player?.play()
            self.isPlaying = true
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            
            return .success
            
        }
        
        commander.pauseCommand.addTarget { [weak self] _ in
            
            guard let self = self else { return .commandFailed }
            self.player?.pause()
            self.isPlaying = false
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            return .success
            
            
        }
        
        commander.skipForwardCommand.addTarget { [weak self] _ in
            
            guard let self = self else { return .commandFailed}
            
            self.skip(seconds: 15)
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            
            
            return .success
        }
        
        commander.skipBackwardCommand.addTarget { [weak self] _ in
            
            guard let self = self else { return .commandFailed }
            self.down(seconds: 15)
            self.updateNowPlaying(title: currentTitle, country: currentCountry)
            return .success
            
        }
        
    }
    
}

extension AudioEngine {
    
    func setupAudioSession() {
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Играть в фоне разрешено")
            
            
        } catch {
            
            print("Ошибка настройки сесси: \(error.localizedDescription)")
            
            
        }
        
        
        
    }
    
    
    
}
