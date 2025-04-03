//
//  ViewController.swift
//  Example
//
//  Created by Admin on 3/4/25.
//

import MiTuKit
import MTMedia

class ViewController: UIViewController {

    private let fileManager = FileManager.default
    private var cacheURL: URL? {
        guard
            let cachesDirectory = fileManager.urls(
                for: .cachesDirectory,
                in: .userDomainMask
            ).first
        else {
            return nil
        }
        return cachesDirectory
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random

        UIButton() >>> view >>> {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.height.equalTo(45)
                $0.width.equalTo(145)
            }
            $0.backgroundColor = .random
            $0.setTitle("Merge", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.handle {
                self.sampleHandle()
            }
        }
    }

}

extension ViewController {
    func sampleHandle() {
        Task(priority: .high) {
            self.showLoading(color: .white)
            if let url = await self.mergeVideo() {
                
                self.share(items: [url])
                self.hideLoading()
            }
        }
    }

    func mergeVideo() async -> URL? {
        guard
            let videoUrl = Bundle.main.url(
                forResource: "video",
                withExtension: "mp4"
            ),
            let imageUrl = Bundle.main.url(
                forResource: "cover",
                withExtension: "jpeg"
            )
        else {
            printDebug("Cannot find video or image")
            return nil
        }

        guard
            let outputUrl = cacheURL?.appendingPathComponent(
                "\(Date().timeIntervalSince1970).mp4"
            )
        else {
            printDebug("Cannot create output url")
            return nil
        }

        let command =
            "-i \(videoUrl.getPath) -i \(imageUrl.getPath) -filter_complex \"[1:v]scale=1280:720[img];[0:v][img]overlay=0:0:enable='between(t,0,2)'\" -c:a copy \(outputUrl.getPath)"

        guard let session = await MTMedia.execute(command) else {
            return nil
        }

        if session.isSuccess() {
            return await video2GIF(inputUrl: outputUrl)
        } else {
            return nil
        }
    }

    func video2GIF(inputUrl: URL) async -> URL? {
        guard
            let outputUrl = cacheURL?.appendingPathComponent(
                "\(Date().timeIntervalSince1970).gif"
            )
        else {
            printDebug("Cannot create output url")
            return nil
        }
        let command =
            "-i \(inputUrl.getPath) -vf \"fps=20,scale=640:360:flags=lanczos\" -c:v gif \(outputUrl)"

        guard let session = await MTMedia.execute(command) else {
            return nil
        }

        return session.isSuccess() ? outputUrl : nil

    }
}
