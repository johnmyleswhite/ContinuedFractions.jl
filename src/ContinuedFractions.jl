module ContinuedFractions
	export ContinuedFraction, convergents

	type ContinuedFraction
		quotients::Vector{Int}
	end

	# TODO: Add quotients function

	function approximate(quotients::Vector{Int})
		s = 0.0

		n_quotients = length(quotients)

		for i in n_quotients:-1:2
			s += quotients[i]
			s = 1.0 / s
		end

		return quotients[1] + s
	end

	function convergents(cf::ContinuedFraction, t::Type)
		n_quotients = length(cf.quotients)

		a = cf.quotients

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

	convergents(cf::ContinuedFraction) = convergents(cf, Float64)

	function ContinuedFraction(x::Real)
		tolerance = 10e-16
		max_quotients = 500

		input = x
		quotients = Array(Int, max_quotients)

		i = 1
		quotients[i] = ifloor(x)
		x = 1 / (x - quotients[i])

		while abs(approximate(quotients[1:i]) - input) > tolerance
			i += 1
			quotients[i] = ifloor(x)
			x = 1 / (x - quotients[i])
		end

		return ContinuedFraction(quotients[1:i])
	end
end
