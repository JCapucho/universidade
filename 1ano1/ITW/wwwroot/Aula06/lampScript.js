let img = document.getElementById("lamp");
let kaboomText = document.getElementById("kaboom");
let kaboom = false;
let vezesClick = 0;

function ligar() {
  img.src = "https://i.stack.imgur.com/ybxlO.jpg";

  if (vezesClick++ >= 10) {
    kaboom = true;
    kaboomText.style.display = "block";

    img.src =
      "https://img.freepik.com/free-vector/realistic-broken-light-bulb-with-pieces_23-2149129543.jpg?w=826&t=st=1667407073~exp=1667407673~hmac=aae8a9e25fe3c304667e184589b5253495773532375642f2ef93f1967c68c327";
  }
}

function desligar() {
  if (kaboom) return;
  img.src = "https://i.stack.imgur.com/b983w.jpg";
}
