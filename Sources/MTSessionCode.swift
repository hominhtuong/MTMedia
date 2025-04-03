//
//  MTSessionCode.swift
//  MTMedia
//
//  Created by Mitu Ultra on 16/3/25.
//

import ffmpegkit

/// MTSessionCode represents the return code of a session (FFmpeg or FFprobe).
/// It encapsulates the return code and provides utility methods to check different states (success, error, cancel).
/// This class allows easy checking of the session status.
public class MTSessionCode {
    /// The return code associated with the session
    public let code: ReturnCode
    
    /// Initializes with a `ReturnCode`
    /// - Parameter returnCode: The return code associated with the session.
    public init(_ returnCode: ReturnCode) {
        code = returnCode
    }
    
    /// Retrieves the integer value of the return code.
    /// - Returns: The integer value of the return code.
    public func getValue() -> Int32 {
        return code.getValue()
    }
    
    /// Checks if the return code indicates a cancellation state.
    /// - Returns: `true` if the return code indicates cancellation, otherwise `false`.
    public func isValueCancel() -> Bool {
        return code.isValueCancel()
    }
    
    /// Checks if the return code indicates an error state.
    /// - Returns: `true` if the return code indicates an error, otherwise `false`.
    public func isValueError() -> Bool {
        return code.isValueError()
    }
    
    /// Checks if the return code indicates a successful execution.
    /// - Returns: `true` if the return code indicates success, otherwise `false`.
    public func isValueSuccess() -> Bool {
        return code.isValueSuccess()
    }
}
