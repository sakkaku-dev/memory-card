extends CardMatcher

class_name NumberColorCardMatcher

var red_color = [PokerCard.DIAMOND, PokerCard.HEART]
var black_color = [PokerCard.SPADE, PokerCard.CLUB]


func match_cards(cards: Array) -> bool:
	var first_card = cards.front() as PokerCard
	var valid_colors = red_color if red_color.has(first_card.suit) else black_color
	
	var card_match = 0
	for card in cards:
		if card.value == first_card.value and valid_colors.has(card.suit):
			card_match += 1
	
	return card_match == 2


func is_max_revealed_cards(cards: Array) -> bool:
	return cards.size() >= 2
