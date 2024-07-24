function portal_get_sprites(index) {
	switch (index mod 6) {
		case 0:
			return {
				spr_back : sprPortalBackPurple,
				spr_fx : sprFXPortalPurple
			}
		case 1:
			return {
				spr_back : sprPortalBackBlue,
				spr_fx : sprFXPortalBlue
			}
		case 2:
			return {
				spr_back : sprPortalBackGray,
				spr_fx : sprFXPortalGray
			}
		case 3:
			return {
				spr_back : sprPortalBackGreen,
				spr_fx : sprFXPortalGreen
			}
		case 4:
			return {
				spr_back : sprPortalBackOrange,
				spr_fx : sprFXPortalOrange
			}
		case 5:
			return {
				spr_back : sprPortalBackYellow,
				spr_fx : sprFXPortalYellow
			}
	}
}