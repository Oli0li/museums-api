# Museum API

This is a project I worked on to practice using an API, rendering data as JSON and scraping.
I populated the database by scraping a list of museums on Timeout London website to get museum names and their postcode.
There are 4 endpoints:

## To see all museums in the database

Go to the root path: https://oli0li-museum-api.herokuapp.com  

## To search for a museum in the database by name

Use "https://oli0li-museum-api.herokuapp.com/api/v1/search?name=YOUR_QUERY" and replace "YOUR_QUERY" by the name you wish to look for.

## To search for a museum in the database by postcode

Use "https://oli0li-museum-api.herokuapp.com/api/v1/search?postcode=YOUR_QUERY" and replace "YOUR_QUERY" by the postcode you wish to look for.

## To search for museums and their postcodes by latitude and longitude

Use "https://oli0li-museum-api.herokuapp.com/api/v1/search?lat=YOUR_QUERY&long=YOUR_QUERY" and replace "YOUR_QUERY" by the latitude and longitude you wish to look for.   
For example, for museums in central London, you could use "https://oli0li-museum-api.herokuapp.com/api/v1/search?lat=51.51&long=-0.13".  

Here, I am using the Mapbox Geocoding API to get the names of museums around those coordinates, and I send the result back grouped by postcode. The names of the museums do not come from my own database.
