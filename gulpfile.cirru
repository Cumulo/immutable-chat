
var
  gulp $ require :gulp
  sequence $ require :run-sequence
  exec $ . (require :child_process) :exec
  env $ object
    :dev true
    :main :http://repo:8080/build/main.js
    :vendor :http://repo:8080/build/vendor.js

gulp.task :rsync $ \ (cb)
  var
    wrapper $ require :rsyncwrapper
  wrapper.rsync
    object
      :ssh true
      :src $ array :index.html :build :images :style :src :processes.json :package.json
      :recursive true
      :args $ array :--verbose
      :dest :aliyun:/home/chen/repo/Cumulo/immutable-chat
      :deleteAll true
    \ (error stdout stderr cmd)
      if (? error)
        do $ throw error
      console.error stderr
      console.log cmd
      cb

gulp.task :script $ \ ()
  var
    script $ require :gulp-cirru-script

  ... gulp
    src :src/**/*.cirru
    pipe $ script $ {} (:es6 true)
    pipe $ gulp.dest :lib/

gulp.task :html $ \ (cb)
  var
    html $ require :./template
    fs $ require :fs
    assets
  if (not env.dev) $ do
    = assets $ require :./build/assets.json
    = env.main $ + :./build/ $ . assets.main 0
    = env.style $ + :./build/ $ . assets.main 1
    = env.vendor $ + :./build/ assets.vendor
  fs.writeFile :index.html (html env) cb

gulp.task :del $ \ (cb)
  var
    del $ require :del
  del (array :build) cb

gulp.task :webpack $ \ (cb)
  var
    command $ cond env.dev :webpack ":webpack --config webpack.min.cirru --progress"
  exec command $ \ (err stdout stderr)
    console.log stdout
    console.log stderr
    cb err

gulp.task :build $ \ (cb)
  = env.dev false
  sequence :del :webpack :html cb
