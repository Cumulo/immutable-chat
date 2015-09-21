
var
  stir $ require :stir-template
  (object~ html head title meta link script body div) stir

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null :Chat
        meta $ {} (:charset :utf-8)
        link $ {} (:rel :icon)
          :href :images/chat.png
        cond data.dev undefined
          link $ {} (:rel :stylesheet)
            :href data.style
        script $ {} (:src data.vendor) (:defer true)
        script $ {} (:src data.main) (:defer true)
      body ({} (:style ":margin: 0;"))
