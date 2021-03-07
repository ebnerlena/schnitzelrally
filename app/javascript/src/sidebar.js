document.addEventListener("turbolinks:load", manageSidebarAppearance);
let sidebarTrigger, sidebar;

function manageSidebarAppearance() {
    sidebarTrigger =  document.querySelector(".sidebar__trigger");
    sidebar = document.querySelector(".sidebar");

    sidebarTrigger.onclick = () => {
        sidebar.classList.toggle("sidebar--open");
        sidebarTrigger.classList.toggle("sidebar--open");
    }
}