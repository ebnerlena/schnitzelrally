import consumer from "./consumer"

let url, dataDiv, splittedPath, playerId, routeId, routeChannel, pathName;

document.addEventListener("turbolinks:load", routeStreaming);

function routeStreaming() {

    pathName = window.location.pathname;
    splittedPath = pathName.split("/");
    if (splittedPath.length > 2) {
        if ((splittedPath[1]=="routes") && splittedPath[2].match(/[0-9]+/)) {

            dataDiv = document.querySelector('#dataDiv');
            if ( dataDiv ) {
                playerId = dataDiv.dataset['player_id'];
                routeId = dataDiv.dataset['route_id'];
            }
    
            routeChannel = consumer.subscriptions.create(
                { channel: "RouteChannel", route_id: routeId }, {
                    connected() {
                        console.log("connected successfully at "+routeId);
                    },
                
                    disconnected() {
                        console.log("disconnected");
                    },
                
                    received(data) {
                        if (data.type == "route_start") {
                            //first when the start is pressed - sending to server to update player state before redirecting to page
                            routeChannel.send({ command: 'start', route_id: routeId, player_id: playerId, task_id: data.task_id });
                        }
                        if (data.type == "start") {
                            // is needed here cause else the player can't be updated cause the page is already loading
                            url = window.location.origin + "/routes/"+routeId+"/game_tasks/"+data.task_id;
                            window.location.href = url;
                        }
                        else if (data.type == "route_next_task") {
                            routeChannel.send({ command: 'next_task', route_id: routeId, player_id: playerId, task_id: data.task_id });
                            url = window.location.origin + "/routes/"+routeId+"/game_tasks/"+data.task_id;
                            window.location.href = url;
                        }
                        else if (data.type == "tasks_update") {
                            let tasksNr = document.querySelector('#tasks_nr');
                            tasksNr.innerHTML = data.tasks_nr;
                        }
                        else if (data.type == "route_end") {
                            url = window.location.origin + "/routes/"+routeId
                            window.location.href = url;
                        }
                    }
                }
            ) 
        }
    }
}
