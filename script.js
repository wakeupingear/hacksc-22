document.getElementById("date").innerHTML += new Date().getFullYear();

const links = document.getElementsByTagName("a");
for (var i = 0; i < links.length; i++) {
    links[i].setAttribute("target", "_blank");
}

function eventFire(el, etype) {
    if (el.fireEvent) {
        el.fireEvent('on' + etype);
    } else {
        var evObj = document.createEvent('Events');
        evObj.initEvent(etype, true, false);
        el.dispatchEvent(evObj);
    }
}

/*const scoreContent = document.getElementById("scoreContent");
document.getElementById("scoreToggle").addEventListener("click", () => {
    if (scoreContent.classList.contains("open")) {
        scoreContent.classList.remove("open");
    }
    else {
        scoreContent.classList.add("open");
    }
});

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
*/

const popup = document.getElementById("popup");
document.getElementById("popupToggle").addEventListener("click", () => {
    if (popup.getAttribute("class") === "") {
        popup.setAttribute("class", "popupOpen");
        popup.style.animationName = "fadeIn";
    }
    else {
        popup.setAttribute("class", "");
        popup.style.animationName = "fadeOut";
    }
});

const popupEntries = document.getElementById("popupContent");
for (var i = 0; i < popupEntries.children.length - 1; i++) {
    //popupEntries.children[i].children[0].setAttribute("class","shadow")
    popupEntries.children[i].innerHTML += `
    <div class="popupSpacer"></div>`;
}

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
    localStorage.setItem("token", token);
}

const score = document.getElementById("score");
const scoreHolder = document.getElementById("scoreHolder");
setScore = (newScore) => {
    scoreHolder.innerHTML = "&nbsp;"+newScore;
    score.style.opacity=1;
}
if (highScore!=0) setScore(highScore);
else score.style.opacity=0;

window.onstorage = () => {
    // When local storage changes, dump the list to
    // the console.
    let newScore = parseInt(window.localStorage.getItem('CreatedwithGameMakerStudio2.0.score.ini').replace(/\D/g, ""));
    if (newScore > highScore) {
        highScore = newScore;
        console.log("NEW SCORE: " + highScore);
        localStorage.setItem("highScore", highScore);
        setScore(highScore);
    }
};