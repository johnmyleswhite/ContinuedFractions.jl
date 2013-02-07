module ContinuedFractions
	export ContinuedFraction, convergents

	type ContinuedFraction
		terms::Vector{Int}
	end

	function approximate(terms::Vector{Int})
		s = 0.0

		n_terms = length(terms)

		for i in n_terms:-1:2
			s += terms[i]
			s = 1.0 / s
		end

		return terms[1] + s
	end

	function convergents(cf::ContinuedFraction)
		n_terms = length(cf.terms)

		res = Array(Float64, n_terms)

		for i in 1:n_terms
			res[i] = approximate(cf.terms[1:i])
		end

		return res
	end

	function ContinuedFraction(x::Real)
		tolerance = 10e-16
		max_terms = 50

		input = x
		terms = Array(Int, max_terms)

		i = 1
		terms[i] = ifloor(x)
		x = 1 / (x - terms[i])

		while abs(approximate(terms[1:i]) - input) > tolerance
			i += 1
			terms[i] = ifloor(x)
			x = 1 / (x - terms[i])
		end

		return ContinuedFraction(terms[1:i])
	end
end
