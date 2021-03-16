extends CardMatcher

class_name NumberCardMatcher

func match_cards(cards: Array) -> bool:
	var value = cards.front().value
	
	var card_match = 0
	for card in cards:
		if card.value == value:
			card_match += 1
	
	return card_match == 4


func is_max_revealed_cards(cards: Array) -> bool:
	return cards.size() >= 4
