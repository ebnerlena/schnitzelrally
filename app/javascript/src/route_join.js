
validateJoining = () => {
    let path = window.location.pathname;
    
  
    if (path == "/routes/join") {

        let notice = document.querySelector("#notice");
        notice.innerHTML = "";
  
        document.addEventListener("ajax:complete", (event) => {
            const [status, xhr] = event.detail;

            if(status.status == 204) {
                notice.innerHTML = "Not a valid route ID... please recheck";
            } else {
                notice.innerHTML = "";
            }
            
        });
    }
}


document.addEventListener("turbolinks:load", validateJoining);
document.addEventListener("load", validateJoining);