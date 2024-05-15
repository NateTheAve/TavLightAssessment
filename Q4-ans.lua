void Game::addItemToPlayer(const std::string& recipient, unit16_t itemId) {
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false

    if (!player){
        player = new Player(nullptr);
        playerCreated = true;

        if (!IOLoginData::loadPlayerByName(player, recipient)){
            delete player; --deletes the associated player
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!Item){
        if (playerCreated){
        delete player; --deletes the associated player if's they're created and not used
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);


    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (playerCreated){
        delete player; --deletes the associated player if's they're created and not used
    }
}