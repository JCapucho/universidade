function addNumber(btn) {
	$("input").val((_, old) => old + btn.value)
}

function reset() {
	$("input").val("")
}

function addOperation(op) {
	var current = $("input").val();

	if (current === "" && op.value !== "-") {
		$("input").val("0")
	} else if (current[0] !== "-" && /[\+\-\*\/]/.test(current)) {
		calculateResult()
	}

	$("input").val((_, old) => old + op.value);
}

function calculateResult() {
	var input = $("input").val();

	var leftStr = "";
	var op = "";
	var rightStr = "";

	var state = "left";

	for (var i = 0; i < input.length; i++) {
		if (leftStr !== "" && /[\+\-\*\/]/.test(input[i])) {
			state = "right";
			op = input[i];
			continue
		}

		if (state == "left")
			leftStr += input[i]
		else if (state == "right")
			rightStr += input[i]
	}

	var result = "";
	var left = parseFloat(leftStr || "0");
	var right = parseFloat(rightStr || "0");

	switch (op) {
		case "+":
			result = left + right;
			break
		case "-":
			result = left - right;
			break
		case "*":
			result = left * right;
			break
		case "/":
			if (right !== 0)
				result = left / right;
			else
				result = "Division by zero";
			break
	}

	$("input").val(result)
}
