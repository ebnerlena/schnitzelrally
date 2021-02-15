let map, lngInput, latInput, range, radius;
var re = new RegExp("\\d+");

var markerIcon = L.icon({
    iconUrl: '/location-pin.svg',

    iconSize:     [50, 50],
    iconAnchor:   [25, 50]    
});

render = () => {

    let path = window.location.pathname;
    let splittedPath = path.split("/");
    let lat, long, mapdiv;
    
    if (path == "/routes/new" || path == "/routes") {
        setUpMap();
        const p = document.querySelector(".input-range__value");
        range = document.querySelector(".input-range");
        p.innerHTML = range.value + " km";

        range.oninput = (e) => {
            range = document.querySelector(".input-range");
            p.innerHTML = range.value + " km";

            if(radius != null) {
                radius.setRadius(range.value * 1100);
                radius.redraw();
            }
        }
        map.locate({setView: true, maxZoom: 16});

        function onLocationError(e) {
            map.setView([47.802087, 13.032622], 13);
        }
        
        lngInput = document.querySelector('#route_longitude');
        latInput = document.querySelector('#route_latitude');
        map.once("click", function(e) {
            addMarker(e);
            addRadius(e);
        });
        map.on('locationerror', onLocationError);
    }
    else if (path.endsWith("map")) {
        setUpMap();
        addViewToMap();
        addTasks();
    } 
    else if ((splittedPath[1]=="routes") && (splittedPath[3] == "game_tasks") && splittedPath[4].match(/[0-9]+/) && splittedPath[5] =="edit") {
        setUpMapForGameTask();
        addTasks();
    }
    else if (path.endsWith("game_tasks/new")) {
        setUpMapForGameTask();
    }
    else if ((splittedPath[1]=="routes") && (splittedPath[3] == "game_tasks") && splittedPath[4].match(/[0-9]+/)) {
        setUpMap();
        addViewToMap();
    }
}

setUpMapForGameTask = () => {
    setUpMap();
    addViewToMap();
    lngInput = document.querySelector('#game_task_longitude');
    latInput = document.querySelector('#game_task_latitude');

    let button = document.querySelector('.btn--disabled');
    
    if (lngInput.value > 0 && latInput.value > 0) {
        button.classList.remove('btn--disabled');    
    }

    map.once("click", addMarker);
}

setUpMap = () => {

    let mapContainer = document.querySelector("#map");

    if (mapContainer) {
        map = L.map('map');

        L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png', {
            attribution: 'Tiles &copy; Esri &mdash; Source: Esri, DeLorme, NAVTEQ, USGS, Intermap, iPC, NRCAN, Esri Japan, METI, Esri China (Hong Kong), Esri (Thailand), TomTom, 2012'
        }).addTo(map);
    }
    
}

addViewToMap = () => {
    mapdiv = document.querySelector('#map');

    if (mapdiv) {
        lat = mapdiv.dataset.lat;
        long = mapdiv.dataset.long;

        map.setView([lat, long], 13);
    }
    
    
}

function changeLatLngInput(e) {
    lngInput.value = e.target._latlng.lng;
    latInput.value = e.target._latlng.lat;

    let path = window.location.pathname;
    
    if (path == "/routes/new") {
        radius.setLatLng([e.target._latlng.lat, e.target._latlng.lng]);
        radius.redraw();
    }
}

function addLatLngInput(e) {
    lngInput.value = e.latlng.lng;
    latInput.value = e.latlng.lat;
}

function addMarker(e) {
    let button = document.querySelector('.btn--disabled');

    button.classList.remove('btn--disabled');

    let marker = L.marker([e.latlng.lat, e.latlng.lng], {icon: markerIcon, draggable: true}).addTo(map);
    addLatLngInput(e);
    marker.on("moveend", changeLatLngInput);
}

function addRadius(e) {
    radius = L.circle([e.latlng.lat, e.latlng.lng], {
        color: '#707070',
        fillColor: '#707070',
        fillOpacity: 0.2,
        radius: range.value * 1100
    }).addTo(map); 
}

function addTasks() {
    let tasks = document.querySelector("#tasks")
    
    if (tasks != null) {
        tasks = tasks.dataset.tasks;
        tasks = JSON.parse(tasks);
        tasks.forEach(task => L.marker([task.latitude, task.longitude], {icon: markerIcon}).addTo(map));
    }
}

document.addEventListener("turbolinks:load", render);
document.addEventListener("load", render);
