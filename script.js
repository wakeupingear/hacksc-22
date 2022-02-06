document.getElementById("date").innerHTML += new Date().getFullYear();

const links = document.getElementsByTagName("a");
for (var i = 0; i < links.length; i++) {
    links[i].setAttribute("target", "_blank");
}

const scoreContent = document.getElementById("scoreContent");
document.getElementById("scoreToggle").addEventListener("click", () => {
    if (scoreContent.classList.contains("open")) {
        scoreContent.classList.remove("open");
    }
    else {
        scoreContent.classList.add("open");
    }
});

function eventFire(el, etype) {
    if (el.fireEvent) {
        el.fireEvent('on' + etype);
    } else {
        var evObj = document.createEvent('Events');
        evObj.initEvent(etype, true, false);
        el.dispatchEvent(evObj);
    }
}

const buttonState = ["hover scoreCategory", "scoreCategory"];
const scoreMenuMap = new Map();
const switchScoreMenu = function () {
    for (const [key, value] of scoreMenuMap.entries()) {
        value.setAttribute("class", "hidden");
    }
    for (var i = 0; i < scoreModes.children.length; i++) {
        scoreModes.children[i].setAttribute("class", buttonState[0]);
    }
    scoreMenuMap.get(this.innerHTML).setAttribute("class", "");
    this.setAttribute("class", buttonState[1]);
}
const scoreModes = document.getElementById("scoreModes");
for (var i = 0; i < scoreModes.children.length; i++) {
    const text = scoreModes.children[i].innerHTML;
    const menu = document.getElementById("score" + text);
    scoreMenuMap.set(text, menu);
    scoreModes.children[i].addEventListener("click", switchScoreMenu);
}
eventFire(scoreModes.children[0], "click");

function uuidv4() {
    return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
        (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
    );
}

let highScore = localStorage.getItem("highScore");
if (highScore === null) highScore = 0;
let token = localStorage.getItem("token");
if (token === null) {
    token = uuidv4();
    alert(token)
    localStorage.setItem("token", token);
}
/*
const socket = io("ws://localhost:5509");
socket.on("score", score => {
    highScore = score;
});
*/