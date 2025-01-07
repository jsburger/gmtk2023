/// Represents an "A in B" chance, ex: (1, 3) is 1/3 chance. (1, 100) = 1%.
/// B Defaults to 100
function chance(A, B = 100) {
	return (random(B) < A)
}

/// Chance, but for good effects. Functionally identical atm.
function chance_good(A, B = 100) {
	return chance(A, B)
}

/// Chance, but for detrimental effects. Functionally identical atm.
function chance_bad(A, B = 100) {
	return chance(A, B)
}