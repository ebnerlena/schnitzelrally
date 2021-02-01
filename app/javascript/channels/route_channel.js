import consumer from "./consumer"

const routeChannel = consumer.subscriptions.create(
    { channel: "RouteChannel", room: "Z2lkOi8vcHJvdG90eXBlMDEvUm91dGUvNw" }, {
        received(data) {
            //data
            console.log(data)
        }
    }
)

//routeChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })