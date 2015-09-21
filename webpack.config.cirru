
var
  fs $ require :fs
  webpack $ require :webpack

= module.exports $ {}
  :entry $ {}
    :vendor $ array :react :immutable
      , :webpack-dev-server/client?http://repo:8080
      , :webpack/hot/dev-server
    :main $ array :./src/main

  :output $ {}
    :path :build/
    :filename :[name].js
    :publicPath :http://repo:8080/build/

  :resolve $ {}
    :extensions $ array :.js :.cirru :

  :module $ {}
    :loaders $ array
      {} (:test /\.cirru$) (:loader :react-hot!cirru-script) (:ignore /node_modules)
      {} (:test /\.css$) (:loader :style!css!autoprefixer)
      {} (:test /\.json$) (:loader :json)
      {} (:test "/\\.(png|jpg|svg)$") (:loader :url)

  :plugins $ array
    new webpack.optimize.CommonsChunkPlugin :vendor :vendor.js
