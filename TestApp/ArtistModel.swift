//
//  ArtistModel.swift
//
//  Created by Alexandr Zhuchinskiy on 1/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ArtistModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let topartists = "topartists"
  }

  // MARK: Properties
  public var topartists: TopArtists?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    topartists = TopArtists(json: json[SerializationKeys.topartists])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = topartists { dictionary[SerializationKeys.topartists] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.topartists = aDecoder.decodeObject(forKey: SerializationKeys.topartists) as? TopArtists
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(topartists, forKey: SerializationKeys.topartists)
  }

}
