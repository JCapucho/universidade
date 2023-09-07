let op1 = document.getElementById("op1");
let op2 = document.getElementById("op2");
let res = document.getElementById("res");
let operation = document.getElementById("operation");

function calcula() {
  let op1Parsed = parseFloat(op1.value);
  let op2Parsed = parseFloat(op2.value);
  switch (operation.value) {
    case "+":
      res.value = op1Parsed + op2Parsed;
      break;
    case "-":
      res.value = op1Parsed - op2Parsed;
      break;
    case "*":
      res.value = op1Parsed * op2Parsed;
      break;
    case "/":
      if (op2Parsed == 0) res.value = "Inválido";
      else res.value = op1Parsed / op2Parsed;
      break;
    case "%":
      if (op2Parsed == 0) res.value = "Inválido";
      else res.value = op1Parsed % op2Parsed1;
      break;
    case "!":
      if (op1Parsed < 0) res.value = "Inválido";
      else res.value = factorial(op1Parsed);
      break;
    default:
      res.value = "Inválido";
  }
}

function factorial(n) {
  let i = 1;
  let r = 1;
  while (i <= n) {
    r = r * i;
    i += 1;
  }
  return r;
}

function mudarOp() {
  op2.disabled = operation.value == "!";
}

mudarOp();
