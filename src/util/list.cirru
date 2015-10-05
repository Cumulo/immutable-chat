
var
  Immutable $ require :immutable

var uniqueHelper $ \ (result xs)
  cond (> xs.size 0)
    cond (result.contains (xs.first))
      uniqueHelper result (xs.rest)
      uniqueHelper (result.push (xs.first)) (xs.rest)
    , result

= exports.unique $ \ (xs)
  uniqueHelper (Immutable.List) xs
