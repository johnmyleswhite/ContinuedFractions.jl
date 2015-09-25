using ContinuedFractions

cf = ContinuedFraction(sqrt(2))
@assert quotients(cf)[1] == 1
for i in 2:15
	@assert quotients(cf)[i] == 2
end
@assert abs(collect(convergents(cf))[end] - sqrt(2)) < 10e-16

cf = ContinuedFraction(sqrt(3))
@assert quotients(cf)[1] == 1
for i in 2:15
	if mod(i, 2) == 0
		@assert quotients(cf)[i] == 1
	else
		@assert quotients(cf)[i] == 2
	end
end
@assert abs(collect(convergents(cf))[end] - sqrt(3)) < 10e-16

cf = ContinuedFraction(1e)
@assert quotients(cf)[1] == 2
for i in 2:15
	if mod(i, 3) == 0
		@assert quotients(cf)[i] == fld(i, 3) * 2
	else
		@assert quotients(cf)[i] == 1
	end
end
