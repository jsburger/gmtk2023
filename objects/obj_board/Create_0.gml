/// @description hiii obj_board
// You can write your code in this editor

//width = 600
//height = 700

become_active = false;
//Allows the shooter to act
active = false;

// Activates when clicked and not targeting
on_click = function() {
	if !active {
		become_active = 2
	}
}

// Takes priority over on_click when CombatRunner is targeting.
get_target_info = function() {
	return {
		type: TARGET_TYPE.BOARD
	}
}

//For drawing shadows
shadow_surface = -1;

editor = false;
canplace = true;
entity_num = 0;
entity_subnum = 0;
current_entity = obj_block;
current_sprite = mskNone;
obj_layer = 0;
entity_list = [
/*Bricks*/    [obj_block, obj_block_v], [obj_block_large, obj_block_large_v], [obj_block_metal, obj_block_metal_v],
/*Money*/     [obj_cash_wad, obj_block_gold], [obj_coin_pouch], [obj_vault],
/*Movement 1*/[obj_bumper, obj_color_bumper],
/*Movement 2*/[obj_portal, obj_portal_1, obj_portal_2, obj_portal_3, obj_portal_4, obj_portal_5],
/*Movement 3*/[obj_launcher_u, obj_launcher_ur, obj_launcher_r, obj_launcher_dr, obj_launcher_d, obj_launcher_dl, obj_launcher_l, obj_launcher_ul],
/*Explosives*/[obj_super_block, obj_super_block_v], [obj_bomb, obj_color_bomb],
/*Logic 1*/	  [obj_switch_on_d, obj_switch_on_r, obj_switch_on_u, obj_switch_on_l],
/*Logic 2*/	  [obj_cable_h, obj_cable_v, obj_cable_ld, obj_cable_lu, obj_cable_ru, obj_cable_rd],
/*Logic 3*/   [obj_and_gate_up, obj_and_gate_right, obj_and_gate_down, obj_and_gate_left], [obj_bridge_u, obj_bridge_r, obj_bridge_d, obj_bridge_l], [obj_lamp], [obj_block_toggle, obj_block_toggle_off],
/*Ball*/      [obj_ballplacer],
/*Battler*/   [BattlerBrick]
];
entity_sprite = [
[sprBrick, sprBrickVertical], [sprBrickLarge, sprBrickLargeVertical], [sprBrickLargeMetal, sprBrickLargeMetalVertical],
[sprBrickCash, sprBrickGold], [sprCoinBagIdleA], [sprVaultIdle],
[sprBumper, sprColorBumperIdle],
[sprPortalBackPurple, sprPortalBackYellow, sprPortalBackOrange, sprPortalBackGreen, sprPortalBackBlue, sprPortalBackGray],
[sprLauncher90, sprLauncher45, sprLauncher0, sprLauncher315, sprLauncher270, sprLauncher225, sprLauncher180, sprLauncher135],
[sprBrickPipebomb, sprBrickPipebombVertical], [sprBomb, sprColorBomb],
[sprSwitchDownOn, sprSwitchRightOn, sprSwitchUpOn, sprSwitchLeftOn],
[sprCableLeftRight, sprCableUpDown, sprCableLeftDown, sprCableLeftUp, sprCableRightUp, sprCableRightDown],
[sprANDGateUp, sprANDGateLeft, sprANDGateDown, sprANDGateRight], [sprCableBridgeUp, sprCableBridgeRight, sprCableBridgeDown, sprCableBridgeLeft], [sprLampOff], [sprBrickToggleOn, sprBrickToggleOff],
[sprBallPlace],
[sprEnemyFrame]
];

mx = 0;
my = 0;

enum editorMode {
	build,
	paint
}
mode = editorMode.build
paintcolor = -1