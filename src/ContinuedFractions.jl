module ContinuedFractions
	export ContinuedFraction, quotients, convergents

	type ContinuedFraction
		quotients::Vector{Int}
	end

	quotients(cf::ContinuedFraction) = cf.quotients

	function convergents(a::Vector{Int}, t::Type)
		n_quotients = length(a)

		p = Array(Int, n_quotients - 1)
		q = Array(Int, n_quotients - 1)
		c = Array(t, n_quotients)

		p0, q0 = a[1], 1
		p[1], q[1] = a[2] * a[1] + 1, a[2]
		p[2], q[2] = a[3] * p[1] + p0, a[3] * q[1] + q0

		for k in 3:(n_quotients - 1)
			p[k] = a[k + 1] * p[k - 1] + p[k - 2]
			q[k] = a[k + 1] * q[k - 1] + q[k - 2]
		end

		if t <: Rational
			c[1] = Rational(a[1], 1)
			for k in 2:n_quotients
				c[k] = Rational(p[k - 1], q[k - 1])
			end
		else
			c[1] = a[1] / 1
			for k in 2:n_quotients
				c[k] = p[k - 1] / q[k - 1]
			end
		end

		return c
	end
	convergents(q::Vector{Int}) = convergents(q, Float64)
	function convergents(cf::ContinuedFraction, t::Type)
		convergents(cf.quotients, t)
	end
	function convergents(cf::ContinuedFraction)
		convergents(cf.quotients, Float64)
	end

	function ContinuedFraction(x::Real)
		tolerance, max_quotients = 10e-16, 500

		input = x
		q = Array(Int, max_quotients)

		i, converged = 0, false

		while !converged
			i += 1
			q[i] = ifloor(x)
			x = 1 / (x - q[i])
			if abs(convergents(q)[i] - input) < tolerance
				converged = true
			end
		end

		return ContinuedFraction(q[1:i])
	end
end
