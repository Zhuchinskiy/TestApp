//
//  Album.swift
//
//  Created by Alexandr Zhuchinskiy on 1/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Album: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let playcount = "playcount"
    static let artist = "artist"
    static let image = "image"
    static let url = "url"
    static let mbid = "mbid"
  }

  // MARK: Properties
  public var name: String?
  public var playcount: Int?
  public var artist: Artist?
  public var image: [Image]?
  public var url: String?
  public var mbid: String?

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
    name = json[SerializationKeys.name].string
    playcount = json[SerializationKeys.playcount].int
    artist = Artist(json: json[SerializationKeys.artist])
    if let items = json[SerializationKeys.image].array { image = items.map { Image(json: $0) } }
    url = json[SerializationKeys.url].string
    mbid = json[SerializationKeys.mbid].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = playcount { dictionary[SerializationKeys.playcount] = value }
    if let value = artist { dictionary[SerializationKeys.artist] = value.dictionaryRepresentation() }
    if let value = image { dictionary[SerializationKeys.image] = value.map { $0.dictionaryRepresentation() } }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = mbid { dictionary[SerializationKeys.mbid] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.playcount = aDecoder.decodeObject(forKey: SerializationKeys.playcount) as? Int
    self.artist = aDecoder.decodeObject(forKey: SerializationKeys.artist) as? Artist
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? [Image]
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.mbid = aDecoder.decodeObject(forKey: SerializationKeys.mbid) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(playcount, forKey: SerializationKeys.playcount)
    aCoder.encode(artist, forKey: SerializationKeys.artist)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(mbid, forKey: SerializationKeys.mbid)
  }

}
