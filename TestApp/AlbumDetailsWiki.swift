//
//  AlbumDetailsWiki.swift
//
//  Created by Alexandr Zhuchinskiy on 1/5/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AlbumDetailsWiki: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let published = "published"
    static let content = "content"
  }

  // MARK: Properties
  public var summary: String?
  public var published: String?
  public var content: String?

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
    summary = json[SerializationKeys.summary].string
    published = json[SerializationKeys.published].string
    content = json[SerializationKeys.content].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = published { dictionary[SerializationKeys.published] = value }
    if let value = content { dictionary[SerializationKeys.content] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.published = aDecoder.decodeObject(forKey: SerializationKeys.published) as? String
    self.content = aDecoder.decodeObject(forKey: SerializationKeys.content) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(published, forKey: SerializationKeys.published)
    aCoder.encode(content, forKey: SerializationKeys.content)
  }

}
