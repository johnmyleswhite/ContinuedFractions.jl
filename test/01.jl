using ContinuedFractions

cf = ContinuedFraction(sqrt(2))

@assert abs(convergents(cf)[end] - sqrt(2)) < 10e-16

cf = ContinuedFraction(sqrt(3))

@assert abs(convergents(cf)[end] - sqrt(3)) < 10e-16

cf = ContinuedFraction(pi)
