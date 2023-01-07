# Museum API

This is a project I worked on to practice using an API, rendering data as JSON and scraping. The app is no longer online.
I populated the database by scraping a list of museums on Timeout London website to get museum names and their postcode.
There are 4 endpoints:

- One to see all museums in the database
- One to search for a museum in the database by name
- One to search for a museum in the database by postcode
- One to search for museums and their postcodes by latitude and longitude (here, I am using the Mapbox Geocoding API to get the names of museums around those coordinates, and I send the result back grouped by postcode. The names of the museums do not come from my own database.)
