immutable ConvergentIterator{T<:Integer,CF<:ContinuedFraction}
    cf::CF
end

ConvergentIterator{T}(cf::ContinuedFraction{T}) = ConvergentIterator{T,typeof(cf)}(cf)

convergents(x::Real) = ConvergentIterator(continuedfraction(x))

start{T,CF}(it::ConvergentIterator{T,CF}) = start(it.cf), one(T)//zero(T), zero(T)//one(T)
done(it::ConvergentIterator, state) = done(it.cf, state[1])

length(it::ConvergentIterator) = length(it.cf)

function next(it::ConvergentIterator, state)
    i, r, r_p  = state
    q, i_n = next(it.cf, i)
    r_n = (q*r.num + r_p.num) // (q*r.den + r_p.den)
    return r_n, (i_n, r_n, r)
end

eltype{T,CF}(it::ConvergentIterator{T,CF}) = Rational{T}

