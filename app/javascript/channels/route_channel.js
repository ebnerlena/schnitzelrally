import consumer from "./consumer"

let dataDiv, splittedPath, playerId, routeName, routeId, routeChannel, pathName;

document.addEventListener("turbolinks:load", lookForButtons);


function lookForButtons() {
    pathName = window.location.pathname;
    splittedPath = pathName.split("/");

    dataDiv = document.querySelector('#dataDiv');
    if ( dataDiv ) {
        playerId = dataDiv.dataset['player_id'];
    }

    if (pathName.endsWith("map") || (splittedPath[1]=="routes") && splittedPath[2].match(/[0-9]+/)) {

        let startBtn = document.getElementById('start_btn');
        let arrivedBtn = document.getElementById('arrived_btn');

        routeName = dataDiv.dataset['route_name'];
        routeId = dataDiv.dataset['route_id'];

        routeChannel = consumer.subscriptions.create(
            { channel: "RouteChannel", route_id: routeId }, {
                connected() {
                    console.log("connected successfully");
                },
            
                disconnected() {
                    // Called when the subscription has been terminated by the server
                    console.log("disconnected");
                },
            
                received(data) {
                    console.log("Receiving some data: ");
                    console.log(data);
                    let url = window.location.origin + "/routes/"+routeId+"/game_tasks/"+data.task;

                    if(data.task_state == "planning" || data.task_state == "hint" || data.task_state == "task")
                        window.location.href = url;
                }
            }
        ) 

        if( startBtn ) {
            startBtn.addEventListener('click',function(){
            console.log("I want to start the game! "+ playerId + "route: "+ routeName);
            routeChannel.send({ command: 'start', route_id: routeId, player_name: playerId });
            });
        }

        if( arrivedBtn ) {
            let task_id = dataDiv.dataset['task_id'];
            arrivedBtn.addEventListener('click',function(){
            console.log("We arrived at the hint! "+ playerId + "route: "+ routeName);
            routeChannel.send({ command: 'arrived', route_id: routeId, player_name: playerId, task_id: task_id });
            });
        }
    }
}
