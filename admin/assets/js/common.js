/* function toast(heading, text, icon) {
    $.toast({
        heading: heading,
        text: text,
        icon: icon,
        loader: true, // Change it to false to disable loader
        loaderBg: '#9EC600', // To change the background
        position: 'top-right',
    });
} */

function successToast(text) {
  Toastify({
    text: text,
    duration: 3000,
    backgroundColor: 'linear-gradient(to right, #56ab2f, #a8e063)',
    close: true,
  }).showToast();
}

function dangerToast(text) {
  Toastify({
    text: text,
    duration: 3000,
    backgroundColor: 'linear-gradient(to right, #ED213A, #93291E)',
    close: true,
  }).showToast();
}

function infoToast(text) {
  Toastify({
    text: text,
    duration: 3000,
    backgroundColor: 'linear-gradient(to right, #2193b0, #6dd5ed)',
    close: true,
  }).showToast();
}

function warnToast(text) {
  Toastify({
    text: text,
    duration: 3000,
    backgroundColor: 'linear-gradient(to right, #CAC531, #F3F9A7)',
    close: true,
  }).showToast();
}
