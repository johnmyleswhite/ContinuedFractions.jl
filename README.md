ContinuedFractions.jl
=====================

# Usage
```julia
julia> using ContinuedFractions

julia> cf = ContinuedFraction(sqrt(2))
ContinuedFraction{Int64}([1,2,2,2,2,2,2,2,2,2  …  2,2,2,2,2,2,2,2,2,3])

julia> convergents(cf)
22-element Array{Rational{Int64},1}:
        0//1
        1//1
        3//2
        7//5
       17//12
       41//29
       99//70
      239//169
      577//408
     1393//985
         ⋮
    47321//33461
   114243//80782
   275807//195025
   665857//470832
  1607521//1136689
  3880899//2744210
  9369319//6625109
 22619537//15994428
 77227930//54608393
```
