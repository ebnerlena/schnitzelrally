// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

//= require leaflet

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

var map, lngInput, latInput, range, radius;

var schnitzelIcon = L.icon({
    iconUrl: '/marker.png',

    iconSize:     [50, 50]
});

// window.onload = (e) => {
//     render();
// }

render = () => {

    let path = window.location.pathname;
    let lat, long, mapdiv;
    
    if (path == "/routes/new") {
        setUpMap();
        const p = document.querySelector(".input-range_value");
        range = document.querySelector(".input-range");
        p.innerHTML = range.value + " km";

        range.oninput = (e) => {
            range = document.querySelector(".input-range");
            p.innerHTML = range.value + " km";
        }
        map.locate({setView: true, maxZoom: 16});

        function onLocationError(e) {
            map.setView([47.802087, 13.032622], 13);
        }
        
        lngInput = document.querySelector('#route_longitude');
        latInput = document.querySelector('#route_latitude');
        map.once("click", addMarker);
        map.on('locationerror', onLocationError);
    }
    else if (path.endsWith("map")) {
        setUpMap();
        addViewToMap();
    } 
    else if (path.endsWith("game_tasks/new") || path.endsWith("edit")) {

        setUpMap();
        addViewToMap();

        lngInput = document.querySelector('#game_task_longitude');
        latInput = document.querySelector('#game_task_latitude');

        map.once("click", addMarker);
    
    }
}

setUpMap = () => {
    map = L.map('map');

    L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png', {
        attribution: 'Tiles &copy; Esri &mdash; Source: Esri, DeLorme, NAVTEQ, USGS, Intermap, iPC, NRCAN, Esri Japan, METI, Esri China (Hong Kong), Esri (Thailand), TomTom, 2012'
    }).addTo(map);
}

addViewToMap = () => {
    mapdiv = document.querySelector('#map');
    lat = mapdiv.dataset.lat;
    long = mapdiv.dataset.long;

    map.setView([lat, long], 13);
}

document.addEventListener('DOMContentLoaded', render);

function changeLatLngInput(e) {
    lngInput.value = e.target._latlng.lng;
    latInput.value = e.target._latlng.lat;
    radius._latlng.lat = e.target._latlng.lat;
    radius._latlng.lng = e.target._latlng.lng;
    console.log(radius);
}

function addLatLngInput(e) {
    lngInput.value = e.latlng.lng;
    latInput.value = e.latlng.lat;
}

function addMarker(e) {
    let marker = L.marker([e.latlng.lat, e.latlng.lng], {icon: schnitzelIcon, draggable: true}).addTo(map);
    addLatLngInput(e);
    addRadius(e.latlng.lat, e.latlng.lng);
    marker.on("moveend", changeLatLngInput);
}

function addRadius(lat, long) {
    radius = L.circle([lat, long], {
        color: '#7f6042',
        fillColor: '#7f6042',
        fillOpacity: 0.2,
        radius: range.value * 50
    }).addTo(map); 
}
