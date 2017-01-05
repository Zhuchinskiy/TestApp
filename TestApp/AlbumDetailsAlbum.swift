//
//  AlbumDetailsAlbum.swift
//
//  Created by Alexandr Zhuchinskiy on 1/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AlbumDetailsAlbum: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let artist = "artist"
    static let name = "name"
    static let image = "image"
    static let mbid = "mbid"
    static let tracks = "tracks"
    static let playcount = "playcount"
    static let wiki = "wiki"
    static let tags = "tags"
    static let listeners = "listeners"
    static let url = "url"
  }

  // MARK: Properties
  public var artist: String?
  public var name: String?
  public var image: [AlbumDetailsImage]?
  public var mbid: String?
  public var tracks: AlbumDetailsTracks?
  public var playcount: String?
  public var wiki: AlbumDetailsWiki?
  public var tags: AlbumDetailsTags?
  public var listeners: String?
  public var url: String?

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
    artist = json[SerializationKeys.artist].string
    name = json[SerializationKeys.name].string
    if let items = json[SerializationKeys.image].array { image = items.map { AlbumDetailsImage(json: $0) } }
    mbid = json[SerializationKeys.mbid].string
    tracks = AlbumDetailsTracks(json: json[SerializationKeys.tracks])
    playcount = json[SerializationKeys.playcount].string
    wiki = AlbumDetailsWiki(json: json[SerializationKeys.wiki])
    tags = AlbumDetailsTags(json: json[SerializationKeys.tags])
    listeners = json[SerializationKeys.listeners].string
    url = json[SerializationKeys.url].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = artist { dictionary[SerializationKeys.artist] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = image { dictionary[SerializationKeys.image] = value.map { $0.dictionaryRepresentation() } }
    if let value = mbid { dictionary[SerializationKeys.mbid] = value }
    if let value = tracks { dictionary[SerializationKeys.tracks] = value.dictionaryRepresentation() }
    if let value = playcount { dictionary[SerializationKeys.playcount] = value }
    if let value = wiki { dictionary[SerializationKeys.wiki] = value.dictionaryRepresentation() }
    if let value = tags { dictionary[SerializationKeys.tags] = value.dictionaryRepresentation() }
    if let value = listeners { dictionary[SerializationKeys.listeners] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.artist = aDecoder.decodeObject(forKey: SerializationKeys.artist) as? String
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? [AlbumDetailsImage]
    self.mbid = aDecoder.decodeObject(forKey: SerializationKeys.mbid) as? String
    self.tracks = aDecoder.decodeObject(forKey: SerializationKeys.tracks) as? AlbumDetailsTracks
    self.playcount = aDecoder.decodeObject(forKey: SerializationKeys.playcount) as? String
    self.wiki = aDecoder.decodeObject(forKey: SerializationKeys.wiki) as? AlbumDetailsWiki
    self.tags = aDecoder.decodeObject(forKey: SerializationKeys.tags) as? AlbumDetailsTags
    self.listeners = aDecoder.decodeObject(forKey: SerializationKeys.listeners) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(artist, forKey: SerializationKeys.artist)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(mbid, forKey: SerializationKeys.mbid)
    aCoder.encode(tracks, forKey: SerializationKeys.tracks)
    aCoder.encode(playcount, forKey: SerializationKeys.playcount)
    aCoder.encode(wiki, forKey: SerializationKeys.wiki)
    aCoder.encode(tags, forKey: SerializationKeys.tags)
    aCoder.encode(listeners, forKey: SerializationKeys.listeners)
    aCoder.encode(url, forKey: SerializationKeys.url)
  }

}
