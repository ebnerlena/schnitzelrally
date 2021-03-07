
resolveMultipleChoiceAnswers = () => {
    let path = window.location.pathname;
    let answers = document.querySelector("#mc-answers");
    let opt1,opt2,opt3,opt4,options;

    if (answers) {

        opt1 = document.querySelector("#option1");
        opt2 = document.querySelector("#option2");
        opt3 = document.querySelector("#option3");
        opt4 = document.querySelector("#option4");

        let btn = document.querySelector("#submit_btn");

        if (btn) {

            btn.onclick = (event) => {
                answers.value = `${opt1.value},${opt2.value},${opt3.value},${opt4.value}`; 
            }
        }

        if (answers.value != ""){
            options = answers.value.replaceAll("=>", ":")
            options = JSON.parse(options);
            opt1.value = options.answers.a;
            opt2.value = options.answers.b;
            opt3.value = options.answers.c;
            opt4.value = options.answers.d;
        }
    }
}


document.addEventListener("turbolinks:load", resolveMultipleChoiceAnswers);
document.addEventListener("load", resolveMultipleChoiceAnswers);