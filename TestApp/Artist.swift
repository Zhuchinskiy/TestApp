//
//  Artist.swift
//
//  Created by Alexandr Zhuchinskiy on 1/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Artist: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let listeners = "listeners"
    static let name = "name"
    static let streamable = "streamable"
    static let image = "image"
    static let url = "url"
    static let mbid = "mbid"
  }

  // MARK: Properties
  public var listeners: String?
  public var name: String?
  public var streamable: String?
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
    listeners = json[SerializationKeys.listeners].string
    name = json[SerializationKeys.name].string
    streamable = json[SerializationKeys.streamable].string
    if let items = json[SerializationKeys.image].array { image = items.map { Image(json: $0) } }
    url = json[SerializationKeys.url].string
    mbid = json[SerializationKeys.mbid].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = listeners { dictionary[SerializationKeys.listeners] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = streamable { dictionary[SerializationKeys.streamable] = value }
    if let value = image { dictionary[SerializationKeys.image] = value.map { $0.dictionaryRepresentation() } }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = mbid { dictionary[SerializationKeys.mbid] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.listeners = aDecoder.decodeObject(forKey: SerializationKeys.listeners) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.streamable = aDecoder.decodeObject(forKey: SerializationKeys.streamable) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? [Image]
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.mbid = aDecoder.decodeObject(forKey: SerializationKeys.mbid) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(listeners, forKey: SerializationKeys.listeners)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(streamable, forKey: SerializationKeys.streamable)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(mbid, forKey: SerializationKeys.mbid)
  }

}
