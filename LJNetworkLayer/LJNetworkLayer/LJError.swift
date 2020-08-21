//
//  LJError.swift
//  NetworkLayer
//
//  Created by linto jacob on 20/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import Foundation
public enum CustomError: Error {
    case failedToCreateRequest
    case failedToCreateBoundary
    case failedToCreateHttpBody
    case genericError
    
}
// MARK: - Custom Error Description
extension CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        case .failedToCreateBoundary: return NSLocalizedString("Unable to create boundary string", comment: "")
        case .failedToCreateHttpBody: return NSLocalizedString("Unable to create HTTP body parameters data", comment: "")
        case .genericError: return NSLocalizedString("Something went wrong. Please try again later", comment: "")
        }
    }
}




    
public enum GeneralFailure: Error{
        case failedToCreateRequest
        case failedToCreateBoundary
        case failedToCreateHttpBody
        case genericError
        case invalidURL
    }
    /// The underlying reason the response serialization error occurred.
public enum ResponseSerializationFailureReason: Error {
           /// The server response contained no data or the data was zero length.
           case inputDataNilOrZeroLength
           /// The file containing the server response did not exist.
           case inputFileNil
           /// The file containing the server response could not be read from the associated `URL`.
           case inputFileReadFailed(at: URL)
           /// String serialization failed using the provided `String.Encoding`.
           case stringSerializationFailed(encoding: String.Encoding)
           /// JSON serialization failed with an underlying system error.
           case jsonSerializationFailed(error: Error)
           /// A `DataDecoder` failed to decode the response due to the associated `Error`.
           case decodingFailed(error: Error)
           /// A custom response serializer failed due to the associated `Error`.
           case customSerializationFailed(error: Error)
           /// Generic serialization failed for an empty response that wasn't type `Empty` but instead the associated type.
           case invalidEmptyResponse(type: String)
       }
    

// MARK: -Custom Error Description
extension GeneralFailure: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return "Unable to create the URLRequest object"
        case .failedToCreateBoundary: return "Unable to create boundary string"
        case .failedToCreateHttpBody: return "Unable to create HTTP body parameters data"
        case .genericError: return "Something went wrong. Please try again later"
        case .invalidURL: return "Unable to create URL from given string"
            
        }
    }
}



extension ResponseSerializationFailureReason: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .inputDataNilOrZeroLength:
            return "Response could not be serialized, input data was nil or zero length."
        case .inputFileNil:
            return "Response could not be serialized, input file was nil."
        case let .inputFileReadFailed(url):
            return "Response could not be serialized, input file could not be read: \(url)."
        case let .stringSerializationFailed(encoding):
            return "String could not be serialized with encoding: \(encoding)."
        case let .jsonSerializationFailed(error):
            return "JSON could not be serialized because of error:\n\(error.localizedDescription)"
        case let .invalidEmptyResponse(type):
            return """
            Empty response could not be serialized to type: \(type). \
            Use Empty as the expected type for such responses.
            """
        case let .decodingFailed(error):
            return "Response could not be decoded because of error:\n\(error.localizedDescription)"
        case let .customSerializationFailed(error):
            return "Custom response serializer failed with error:\n\(error.localizedDescription)"
        }
    }
}
