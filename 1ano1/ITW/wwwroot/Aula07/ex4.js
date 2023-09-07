var ones = 0;
var xs = 0;
var twos = 0;

for (var i = 1; i < 14; i++) {
    if ($(`#Jogo${i}_1`).prop("checked"))
        ones++;
    if ($(`#Jogo${i}_x`).prop("checked"))
        xs++;
    if ($(`#Jogo${i}_2`).prop("checked"))
        twos++;
}

$("#Status1").text(ones);
$("#StatusX").text(xs);
$("#Status2").text(twos);

checkValid();

$('input[name="multiplas"]').click(checkValid);

function checkValid() {
    var multiplas = document.querySelector('input[name="multiplas"]:checked');

    var valid = multiplas && (ones > 0 || xs > 0 || twos > 0);

    $("#botao").prop('disabled', !valid);
}

function boxClicked(e) {
    var result = e.name.slice(-1);
    switch (result) {
        case "1":
            if (e.checked)
                ones++;
            else
                ones--;

            $("#Status1").text(ones);
            break;
        case "x":
            if (e.checked)
                xs++;
            else
                xs--;

            $("#StatusX").text(xs);
            break;
        case "2":
            if (e.checked)
                twos++;
            else
                twos--;

            $("#Status2").text(twos);
            break;
    }

    checkValid()
}
