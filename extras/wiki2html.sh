cd $HOME/blog
rm -rf $HOME/blog/public/*
env HUGO_baseURL="$HOME/blog/public/" \
    hugo --themesDir $HOME/blog/themes/ -t LoveIt \
    --config $HOME/blog/config.toml \
    --contentDir $HOME/blog/content/posts \
    -d $HOME/blog/public --quiet > /dev/null
