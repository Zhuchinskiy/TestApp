//
// AttrArtist.swift
//
//  Created by Alexandr Zhuchinskiy on 1/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AttrArtist: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let total = "total"
    static let totalPages = "totalPages"
    static let artist = "artist"
    static let perPage = "perPage"
    static let page = "page"
  }

  // MARK: Properties
  public var total: String?
  public var totalPages: String?
  public var artist: String?
  public var perPage: String?
  public var page: String?

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
    total = json[SerializationKeys.total].string
    totalPages = json[SerializationKeys.totalPages].string
    artist = json[SerializationKeys.artist].string
    perPage = json[SerializationKeys.perPage].string
    page = json[SerializationKeys.page].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = totalPages { dictionary[SerializationKeys.totalPages] = value }
    if let value = artist { dictionary[SerializationKeys.artist] = value }
    if let value = perPage { dictionary[SerializationKeys.perPage] = value }
    if let value = page { dictionary[SerializationKeys.page] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? String
    self.totalPages = aDecoder.decodeObject(forKey: SerializationKeys.totalPages) as? String
    self.artist = aDecoder.decodeObject(forKey: SerializationKeys.artist) as? String
    self.perPage = aDecoder.decodeObject(forKey: SerializationKeys.perPage) as? String
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(total, forKey: SerializationKeys.total)
    aCoder.encode(totalPages, forKey: SerializationKeys.totalPages)
    aCoder.encode(artist, forKey: SerializationKeys.artist)
    aCoder.encode(perPage, forKey: SerializationKeys.perPage)
    aCoder.encode(page, forKey: SerializationKeys.page)
  }

}
