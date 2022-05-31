//
//  FriendAdapter.swift
//  homeWork_1
//
//  Created by Аня on 31.05.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import Foundation
import RealmSwift

class FriendsAdapter {
    
    private let friendsService = AlamofireService()
    private var realmNotificationTokens: [String : NotificationToken] = [:]
    
    func getFriends(in delegate: String, then  completion: @escaping ([Friends] -> Void)) {
        guard let realm = try? Realm(),
              let realmPeople =  realm.object(ofType: VkFriend.self, forPrimaryKey: delegate) else {
                  return
              }
        
        realmNotificationTokens[city]?.invalidate()
        
        let token = realmPeople.friends?.addNotificationBlock { [weak self]
            (changes: RealmCollectionChange) in
            guard let self = self else { return }
            switch changes {
            case .update(let realmFriends, _, _, _):
                var friends: [Friends] = []
                for realmFriend in realmFriends {
                    friends.append(self.friends(from: realmFriend))
                }
                self.realmNotificationTokens[people]?.stop()
                completion(friends)
            case .error(let error):
                fatalError("\(error)")
            case .initial:
                break
            }
        }
        self.realmNotificationTokens[delegate] = token
        
        friendsService.getFriends(delegate: delegate)
    }
    
    func friends(from rlmFriends: VkFriend) -> Friends  {
        return Friends(uid: rlmFriends.uid,
                       online: Int(rlmFriends.online),
                       user_id: rlmFriends.user_id,
                       nickname: rlmFriends.nickname,
                       last_name: rlmFriends.last_name,
                       first_name: rlmFriend.first_name,
                       full_name: rlmFriends.full_name,
                       photo: rlmFriends.photo)
        
    }
}
