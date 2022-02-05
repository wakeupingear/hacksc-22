document.getElementById("date").innerHTML += new Date().getFullYear();

const links = document.getElementsByTagName("a");
for (var i = 0; i < links.length; i++) {
    links[i].setAttribute("target", "_blank");
}

const socket = io();