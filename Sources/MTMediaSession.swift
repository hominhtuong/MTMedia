//
//  MTMediaSession.swift
//  MTMedia
//
//  Created by Mitu Ultra on 16/3/25.
//

import ffmpegkit

/// MTMediaSession represents a media session, which can be either an FFmpeg session or a FFprobe session.
/// It encapsulates the functionality and properties of these sessions to perform media operations and retrieve session details.
/// This class provides various methods to interact with the session, such as checking its success, retrieving logs, and extracting media details.
public class MTMediaSession {
    /// The FFmpeg session, if the session is FFmpeg-based.
    public let ffmpegSession: FFmpegSession?
    
    /// The FFprobe session, if the session is FFprobe-based.
    public let probeSession: FFprobeSession?

    /// Initializes with an FFmpeg session.
    /// - Parameter ffmpegSession: The FFmpeg session.
    public init(_ ffmpegSession: FFmpegSession) {
        self.ffmpegSession = ffmpegSession
        self.probeSession = nil
    }

    /// Initializes with a FFprobe session.
    /// - Parameter probeSession: The FFprobe session.
    public init(_ probeSession: FFprobeSession) {
        self.probeSession = probeSession
        self.ffmpegSession = nil
    }

    /// Retrieves the session being used (preferring FFmpeg session if both are available).
    private var session: AbstractSession? {
        return ffmpegSession ?? probeSession
    }

    /// Retrieves the ID of the session.
    /// - Returns: The ID of the session, or `-1` if no session is available.
    public func getId() -> Int {
        return session?.getId() ?? -1
    }

    /// Retrieves the return code of the session.
    /// - Returns: A `MTSessionCode` representing the return code.
    public func returnCode() -> MTSessionCode {
        return MTSessionCode(session?.getReturnCode() ?? ReturnCode(-1))
    }

    /// Retrieves the output log of the session.
    /// - Returns: The output log, or an empty string if no session is available.
    public func getOutput() -> String {
        return session?.getOutput() ?? ""
    }

    /// Retrieves the duration of the session.
    /// - Returns: The duration in seconds, or `-1` if no session is available.
    public func duration() -> Int {
        return session?.getDuration() ?? -1
    }

    /// Checks if the session completed successfully.
    /// - Returns: `true` if the session is successful, otherwise `false`.
    public func isSuccess() -> Bool {
        return session?.getReturnCode().isValueSuccess() ?? false
    }

    /// Retrieves all logs associated with the session.
    /// - Returns: The full logs as a string, or an empty string if no session is available.
    public func getAllLogs() -> String {
        return session?.getAllLogsAsString() ?? ""
    }

    /// Retrieves the main logs associated with the session.
    /// - Returns: The main logs as a string, or an empty string if no session is available.
    public func getLogs() -> String {
        return session?.getLogsAsString() ?? ""
    }

    /// Checks if the session contains media information (specific to FFprobe).
    /// - Returns: `true` if the session is media information (FFprobe), otherwise `false`.
    public func isMediaInformation() -> Bool {
        return probeSession?.isMediaInformation() ?? false
    }
    
    /// Checks if the session is an FFmpeg session.
    /// - Returns: `true` if the session is FFmpeg, otherwise `false`.
    public func isFFmpeg() -> Bool {
        return ffmpegSession != nil
    }

    /// Checks if the session is a FFprobe session.
    /// - Returns: `true` if the session is FFprobe, otherwise `false`.
    public func isFFprobe() -> Bool {
        return probeSession != nil
    }
    
    /// Retrieves the start time of the session.
    /// - Returns: The start time of the session, or `nil` if not available.
    public func getStartTime() -> Date? {
        return session?.getStartTime()
    }
    
    /// Retrieves the end time of the session.
    /// - Returns: The end time of the session, or `nil` if not available.
    public func getEndTime() -> Date? {
        return session?.getEndTime()
    }
    
    /// Retrieves the create time of the session.
    /// - Returns: The creation time of the session, or `nil` if not available.
    public func getCreateTime() -> Date? {
        return session?.getCreateTime()
    }
}

