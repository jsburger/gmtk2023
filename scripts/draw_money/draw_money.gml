// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_money(_x, _y, moneyString) {

	var xsaved = _x;
	
	_x += 50
	draw_sprite(sprMoneyBack, 0, _x, _y)
	
	_x += 48 * (5 - string_length(moneyString))


	for (var i = 1; i <= string_length(moneyString); i++) { // Fixed
		draw_sprite(sprNumbers, get_number_index(string_char_at(moneyString, i)), _x + (48 * (i - 1)), _y)
	}
	
	draw_sprite(sprDollar, get_animation_frame(2), xsaved, _y)
}

function draw_profit(_x, _y, moneyString) {

	var xsaved = _x;
	
	_x += 50
	draw_sprite(sprMoneyBack, 0, _x, _y)
	
	_x += 48 * (5 - string_length(moneyString))


	var color = (string_count("-", moneyString) ? c_red : c_lime)
	for (var i = 1; i <= string_length(moneyString); i++) { // Fixed
		draw_sprite_ext(sprNumbersWhite, get_number_index(string_char_at(moneyString, i)), _x + (48 * (i - 1)), _y, 1, 1, 0, color, 1)
	}
	
	draw_sprite(sprProfits, 0, xsaved, _y)
}

function draw_payout(_x, _y, moneyString) {

	var xsaved = _x;
	_x += 30
	draw_sprite(sprMoneyBack, 0, _x, _y)
	_x += 48 * (5 - string_length(moneyString))
	for (var i = 1; i <= string_length(moneyString); i++) { // Fixed
		draw_sprite(sprNumbers, get_number_index(string_char_at(moneyString, i)), _x + (48 * (i - 1)), _y)
	}
	draw_sprite(sprChips, get_animation_frame(2), xsaved, _y)
}

function draw_number_panel(_x, _y, numberString, bgColor, maxLength = undefined, scale = 1) {
	maxLength ??= string_length(numberString);
	var gap = 48 * scale;
	for (var i = 0; i < maxLength; i++) {
		draw_sprite_ext(sprNumberBack, 0, _x + gap * i, _y, scale, scale, 0, bgColor, 1)
	}
	_x += gap * (maxLength - string_length(numberString))
	for (var i = 1; i <= string_length(numberString); i++) {
		draw_sprite_ext(sprNumbers, get_number_index(string_char_at(numberString, i)), _x + (gap * (i - 1)), _y,
			scale, scale, 0, c_white, 1)
	}
}

function draw_number_panel_centered(_x, _y, numberString, bgColor, maxLength = undefined, scale = 1) {
	maxLength ??= string_length(numberString);
	draw_number_panel(_x - (24 * (maxLength - 1) * scale), _y, numberString, bgColor, maxLength, scale)
}

function get_number_index(str) {
	switch(str) {
		case "k": return 10
		case "-": return 11
		case "/": return 12
		default: return floor(real(str))
	}
}

function get_short_money(money) {
	if money >= 100000 {
		money /= 1000
		money = floor(money)
		return string(money) + "k"
	}
	return string(money)
}