/// @description Insert description here
// You can write your code in this editor
switch sprite_index {
	default: sprite_index = sprCoinBagIdleA; break;
	case sprCoinBagHurtA: case sprCoinBagIdleB: sprite_index = sprCoinBagIdleB; break;
	case sprCoinBagHurtB: case sprCoinBagIdleC: sprite_index = sprCoinBagIdleC; break;
}
