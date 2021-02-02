document.addEventListener("turbolinks:load", manageSidebarAppearance);
let sidebarTrigger, sidebar;

function manageSidebarAppearance() {
    sidebarTrigger =  document.querySelector(".sidebar_trigger");
    sidebar = document.querySelector(".sidebar");

    sidebarTrigger.onclick = () => {
        sidebar.classList.toggle("open");
        sidebarTrigger.classList.toggle("open");
    }
}