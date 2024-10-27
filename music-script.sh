#/bin/bash

#curl -s "https://api.listenbrainz.org/1/user/lostglory_/listens" | jq '.payload.listens[0] | {artist: .track_metadata.artist_name, track: .track_metadata.track_name, album: .track_metadata.release_name, releaseid: .track_metadata.mbid_mapping.release_mbid}' 

#to get ablum image
#curl -L -H "User-Agent: Mozilla/5.0" -s "https://archive.org/download/mbid-d7fad925-cc94-3070-8f12-6c909cf42c45/index.json" | jq ".images[0].image"

#!/bin/bash

# Get the most recent listen details
listen_data=$(curl -s "https://api.listenbrainz.org/1/user/lostglory_/listens" | jq '.payload.listens[0]')

# Extract required information
artist=$(echo "$listen_data" | jq -r '.track_metadata.artist_name')
track=$(echo "$listen_data" | jq -r '.track_metadata.track_name')
album=$(echo "$listen_data" | jq -r '.track_metadata.release_name')
releaseid=$(echo "$listen_data" | jq -r '.track_metadata.mbid_mapping.release_mbid')

# Output track details
echo "Artist: $artist"
echo "Track: $track"
echo "Album: $album"
echo "Release ID: $releaseid"

# Get the album image
album_image=$(curl -L -H "User-Agent: Mozilla/5.0" -s "https://archive.org/download/mbid-$releaseid/index.json" | jq -r ".images[0].image")

# Output the album image URL
if [ -n $album_image ]; then
    echo "Album Image: $album_image"
else
    echo "No album image found."
fi

