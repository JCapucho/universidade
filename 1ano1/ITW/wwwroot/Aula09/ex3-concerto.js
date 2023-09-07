var modal = new bootstrap.Modal(document.getElementById('errorModal'));
// Example starter JavaScript for disabling form submissions if there are invalid fields
(function () {
    'use strict'

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.querySelectorAll('.needs-validation')

    // Loop over them and prevent submission
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                var twoPlaces = checkPlaces();
                console.log('--- formValidation');
                if (!form.checkValidity() || !twoPlaces) {
                    event.preventDefault();
                    event.stopPropagation();

                    modal.show();

                    var nameInvalid = $('input[name=name]').is(":invalid");
                    var emailInvalid = $('input[name=eMail]').is(":invalid");
                    var addressInvalid = $('textarea[name=morada]').is(":invalid");

                    $("#username-error").toggle(nameInvalid);
                    $("#email-error").toggle(emailInvalid);
                    $("#address-error").toggle(addressInvalid);
                    $("#place-error").toggle(!twoPlaces);
               }

                form.classList.add('was-validated')
            }, false)
        })
})()

function checkPlaces() {
    console.log('--- function checkPlace()');
    //--- versão jQuery 
    var max = 0;
    var checked = $('input[name=local]:checked').length;
    //--- Se checked!=2 coloca o required=true em todos; senão, coloca o required=false em todos
    $('input[name=local]').each(function () {
        if ($(this).prop("checked") && $(this).val() * 1.0 > max) {
            max = $(this).val() * 1.0;
        }
        $(this).prop("required", checked != 2);
    });
    $("#preco").val(max);
    //--- Se checked == 2 retorna true ; senão, retorna false
    return checked == 2;
}
