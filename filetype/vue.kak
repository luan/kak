##
## vue.kak by luan
##

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .+\.vue %{
  set-option buffer filetype vue
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

remove-highlighter shared/vue

add-highlighter shared/ regions vue \
  pug     %{<template\h+lang=('pug'|"pug")>\K}    (?=</template>)  '' \
  script  <script\b.*?>\K                         (?=</script>)    '' \
  scss    %{<style\h+lang=('scss'|"scss")>\K}     (?=</style>)     '' \
  stylus  %{<style\h+lang=('stylus'|"stylus")>\K} (?=</style>)     '' \
  html    <template\b.*?>\K                       (?=</template>)  '' \
  css     <style\b.*?>\K                          (?=</style>)     ''

add-highlighter shared/vue/html    ref html
add-highlighter shared/vue/pug     ref pug
add-highlighter shared/vue/script  ref javascript
add-highlighter shared/vue/css     ref css
add-highlighter shared/vue/scss    ref scss
add-highlighter shared/vue/stylus  ref stylus

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=vue %{
  add-highlighter window ref vue
}

hook global WinSetOption filetype=(?!vue).* %{
  remove-highlighter window/vue
}
