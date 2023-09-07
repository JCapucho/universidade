let nomes = ["Green", "Red", "Yellow", "Blue"];
let quadrados = [];

let nomeText = document.getElementById("nome");
let xText = document.getElementById("x");
let yText = document.getElementById("y");

let controls = document.getElementById("controls");

for (const nome of nomes) {
  let quadrado = document.getElementById(nome);

  quadrado.addEventListener("mouseover", (_) => {
    nomeText.innerText = nome;
    xText.innerText = quadrado.style.left;
    yText.innerText = quadrado.style.top;
  });

  quadrado.addEventListener("mouseout", (_) => {
    nomeText.innerText = "";
    xText.innerText = "";
    yText.innerText = "";
  });

  quadrados.push(quadrado);
}

function baralhar() {
  for (const quadrado of quadrados) {
    let x = randomRange(0, window.innerWidth - quadrado.offsetWidth);
    let y = randomRange(0, window.innerHeight - quadrado.offsetHeight);

    quadrado.style.left = x + "px";
    quadrado.style.top = y + "px";
  }
}

function randomRange(min, max) {
  return Math.random() * (max - min) + min;
}

baralhar();
