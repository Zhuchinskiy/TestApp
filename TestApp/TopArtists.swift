//
//  TopArtists.swift
//
//  Created by Alexandr Zhuchinskiy on 1/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TopArtists: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let artist = "artist"
    static let attr = "@attr"
  }

  // MARK: Properties
  public var artist: [Artist]?
  public var attr: Attr?

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
    if let items = json[SerializationKeys.artist].array { artist = items.map { Artist(json: $0) } }
    attr = Attr(json: json[SerializationKeys.attr])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = artist { dictionary[SerializationKeys.artist] = value.map { $0.dictionaryRepresentation() } }
    if let value = attr { dictionary[SerializationKeys.attr] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.artist = aDecoder.decodeObject(forKey: SerializationKeys.artist) as? [Artist]
    self.attr = aDecoder.decodeObject(forKey: SerializationKeys.attr) as? Attr
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(artist, forKey: SerializationKeys.artist)
    aCoder.encode(attr, forKey: SerializationKeys.attr)
  }

}
