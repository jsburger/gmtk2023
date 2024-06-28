/// Represents an "A in B" chance, ex: (1, 3) is 1/3 chance. (1, 100) = 1%.
/// B Defaults to 100
function chance(A, B = 100) {
	return (random(B) < A)
}