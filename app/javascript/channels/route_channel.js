import consumer from "./consumer"

let dataDiv, splittedPath, playerId, routeId, routeChannel, pathName;

document.addEventListener("turbolinks:load", lookForButtons);

function lookForButtons() {
    pathName = window.location.pathname;
    splittedPath = pathName.split("/");

    if (pathName.endsWith("map") || (splittedPath[1]=="routes") && splittedPath[2].match(/[0-9]+/)) {

        dataDiv = document.querySelector('#dataDiv');
        if ( dataDiv ) {
            playerId = dataDiv.dataset['player_id'];
            routeId = dataDiv.dataset['route_id'];
        }

        let startBtn = document.querySelector('#start_btn');
        let arrivedBtn = document.querySelector('#arrived_btn');      

        routeChannel = consumer.subscriptions.create(
            { channel: "RouteChannel", route_id: routeId }, {
                connected() {
                    console.log("connected successfully");
                },
            
                disconnected() {
                    console.log("disconnected");
                },
            
                received(data) {
                    let url = window.location.origin + "/routes/"+routeId+"/game_tasks/"+data.task;

                    if (data.task_state == "planning" || data.task_state == "hint" || data.task_state == "task") {
                        window.location.href = url;
                    }

                    if (data.type == "tasks_update") {
                        console.log("task update "+ data.tasks_nr)
                        let tasksNr = document.querySelector('#tasks_nr');
                        tasksNr.innerHTML = data.tasks_nr;
                    }
                    if (data.type == "route_end") {
                        url = window.location.origin + "/routes/"+routeId
                        window.location.href = url;
                    }  
                    if (data.type == "next_task") {
                        url = window.location.origin + "/routes/"+routeId+"/game_tasks/"+data.task
                        window.location.href = url;
                    }  
                }
            }
        ) 

        if( startBtn ) {
            startBtn.addEventListener('click',function(){
            routeChannel.send({ command: 'start', route_id: routeId, player_name: playerId });
            });
        }

        if( arrivedBtn ) {
            let task_id = dataDiv.dataset['task_id'];
            arrivedBtn.addEventListener('click',function(){
            routeChannel.send({ command: 'arrived', route_id: routeId, player_name: playerId, task_id: task_id });
            });
        }
    }
}
