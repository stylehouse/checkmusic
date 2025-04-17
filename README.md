# checkmusic

Check for bit rot in music collections.

Players tend to just skip forward when they have decoding problems.

Only uses one cpu core.

## run

    docker compose build
    MUSIC_DIR="/media/.../music/..." docker compose run --rm checkmusic > ohno

Says a tally, writes filenames to *./ohno*.

## TODO

* automatic healing