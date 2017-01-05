//
//  Topalbums.swift
//
//  Created by Alexandr Zhuchinskiy on 1/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Topalbums: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let album = "album"
    static let AttrArtist = "@attr"
  }

  // MARK: Properties
  public var album: [Album]?
  public var attrArtist: AttrArtist?

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
    if let items = json[SerializationKeys.album].array { album = items.map { Album(json: $0) } }
    attrArtist = AttrArtist(json: json[SerializationKeys.AttrArtist])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = album { dictionary[SerializationKeys.album] = value.map { $0.dictionaryRepresentation() } }
    if let value = attrArtist { dictionary[SerializationKeys.AttrArtist] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.album = aDecoder.decodeObject(forKey: SerializationKeys.album) as? [Album]
    self.attrArtist = aDecoder.decodeObject(forKey: SerializationKeys.AttrArtist) as? AttrArtist
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(album, forKey: SerializationKeys.album)
    aCoder.encode(attrArtist, forKey: SerializationKeys.AttrArtist)
  }

}
