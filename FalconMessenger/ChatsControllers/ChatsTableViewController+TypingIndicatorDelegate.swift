//
//  ChatsTableViewController+TypingIndicatorDelegate.swift
//  FalconMessenger
//
//  Created by Roman Mizin on 4/22/18.
//  Copyright © 2018 Roman Mizin. All rights reserved.
//

import UIKit
import RealmSwift

extension ChatsTableViewController: TypingIndicatorDelegate {
  
  func typingIndicator(isActive: Bool, for chatID: String) {
		realmManager.realm.beginWrite()
		realmManager.realm.objects(Conversation.self).filter("chatID = %@", chatID).first?.isTyping.value = isActive
		try! realmManager.realm.commitWrite()
  }
  
  typealias typingUpdateCompletionHandler = (_ isCompleted: Bool, _ updatedConversations: Results<Conversation>, _ row: Int?) -> Void
  
  func update(_ conversations: Results<Conversation>, at chatID: String, with typingStatus: Bool , completion: typingUpdateCompletionHandler ) {
    guard let index = conversations.index(where: { (conversation) -> Bool in
      return conversation.chatID == chatID
    }) else {
      completion(false, conversations, nil)
      return
    }
    completion(true, conversations, index)
  }
}
