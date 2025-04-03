//
//  MTMedia.swift
//  MTMedia
//
//  Created by Mitu Ultra on 16/3/25.
//

import ffmpegkit

/// MTMedia is a utility class for interacting with FFmpeg and FFprobe frameworks to process media files.
///
/// This class provides convenient methods to execute FFmpeg and FFprobe commands synchronously and asynchronously.
/// You can use the functions below to perform media-related operations, such as processing video and audio files.
///
/// To use this class, simply call one of the `execute` or `propeExecute` methods with the desired command or arguments.
///
/// Example usage:
///
/// ```swift
/// // Execute FFmpeg command synchronously
/// let session = MTMedia.execute("-i input.mp4 -vn output.mp3")
///
/// // Execute FFmpeg command asynchronously
/// async {
///     let session = await MTMedia.execute("-i input.mp4 -vn output.mp3")
///     if let session = session {
///         print("Execution completed with ID: \(session.getId())")
///     }
/// }
///
/// // Execute FFprobe command synchronously
/// let session = MTMedia.propeExecute("-v error -show_format input.mp4")
///
/// // Execute FFprobe command asynchronously
/// async {
///     let session = await MTMedia.propeExecute("-v error -show_format input.mp4")
///     if let session = session {
///         print("FFprobe executed successfully with ID: \(session.getId())")
///     }
/// }
/// ```
open class MTMedia: NSObject {
    public static let shared = MTMedia()

    /// Executes a FFmpeg command synchronously and returns a `MTMediaSession` containing the result.
    /// - Parameter command: The FFmpeg command to execute (e.g., "-i input.mp4 -vn output.mp3").
    /// - Returns: A `MTMediaSession` object with the execution result.
    @discardableResult
    public static func execute(_ command: String) -> MTMediaSession {
        return MTMediaSession(FFmpegKit.execute(command))
    }

    /// Executes a FFmpeg command asynchronously and returns a `MTMediaSession` containing the result.
    /// - Parameter command: The FFmpeg command to execute (e.g., "-i input.mp4 -vn output.mp3").
    /// - Returns: A `MTMediaSession` object containing the result if successful, or nil if an error occurred.
    @discardableResult
    public static func execute(_ command: String) async -> MTMediaSession? {
        await withCheckedContinuation { continuation in
            FFmpegKit.executeAsync(command) { session in
                if let session = session {
                    continuation.resume(returning: MTMediaSession(session))
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    /// Executes a FFmpeg command using a set of arguments synchronously and returns a `MTMediaSession`.
    /// - Parameter arguments: The arguments for the FFmpeg command (e.g., ["-i", "input.mp4", "-vn", "output.mp3"]).
    /// - Returns: A `MTMediaSession` object containing the execution result.
    @discardableResult
    public static func execute(arguments: [Any]) -> MTMediaSession {
        return MTMediaSession(FFmpegKit.execute(withArguments: arguments))
    }

    /// Executes a FFmpeg command using a set of arguments asynchronously and returns a `MTMediaSession`.
    /// - Parameter arguments: The arguments for the FFmpeg command (e.g., ["-i", "input.mp4", "-vn", "output.mp3"]).
    /// - Returns: A `MTMediaSession` object containing the result if successful, or nil if an error occurred.
    @discardableResult
    public static func execute(arguments: [Any]) async -> MTMediaSession? {
        await withCheckedContinuation { continuation in
            FFmpegKit.execute(withArgumentsAsync: arguments, withCompleteCallback: { session in
                if let session = session {
                    continuation.resume(returning: MTMediaSession(session))
                } else {
                    continuation.resume(returning: nil)
                }
            })
        }
    }

    /// Executes a FFprobe command synchronously and returns a `MTMediaSession` containing the result.
    /// - Parameter command: The FFprobe command to execute (e.g., "-v error -show_format input.mp4").
    /// - Returns: A `MTMediaSession` object containing the execution result.
    @discardableResult
    public static func propeExecute(_ command: String) -> MTMediaSession {
        return MTMediaSession(FFprobeKit.execute(command))
    }

    /// Executes a FFprobe command asynchronously and returns a `MTMediaSession` containing the result.
    /// - Parameter command: The FFprobe command to execute (e.g., "-v error -show_format input.mp4").
    /// - Returns: A `MTMediaSession` object containing the result if successful, or nil if an error occurred.
    @discardableResult
    public static func propeExecute(_ command: String) async -> MTMediaSession? {
        await withCheckedContinuation { continuation in
            FFprobeKit.executeAsync(command) { session in
                if let session = session {
                    continuation.resume(returning: MTMediaSession(session))
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    /// Executes a FFprobe command using a set of arguments synchronously and returns a `MTMediaSession`.
    /// - Parameter arguments: The arguments for the FFprobe command (e.g., ["-v", "error", "-show_format", "input.mp4"]).
    /// - Returns: A `MTMediaSession` object containing the execution result.
    @discardableResult
    public static func propeExecute(arguments: [Any]) -> MTMediaSession {
        return MTMediaSession(FFprobeKit.execute(withArguments: arguments))
    }

    /// Executes a FFprobe command using a set of arguments asynchronously and returns a `MTMediaSession`.
    /// - Parameter arguments: The arguments for the FFprobe command (e.g., ["-v", "error", "-show_format", "input.mp4"]).
    /// - Returns: A `MTMediaSession` object containing the result if successful, or nil if an error occurred.
    @discardableResult
    public static func propeExecute(arguments: [Any]) async -> MTMediaSession? {
        await withCheckedContinuation { continuation in
            FFprobeKit.execute(withArgumentsAsync: arguments, withCompleteCallback: { session in
                if let session = session {
                    continuation.resume(returning: MTMediaSession(session))
                } else {
                    continuation.resume(returning: nil)
                }
            })
        }
    }
}
