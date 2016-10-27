document.addEventListener("DOMContentLoaded", function() {
  initTerminal();
  animateHeader();
  animateSections();
});

function initTerminal() {
  var t = new Terminal({
    dom: document.getElementById('terminal'),
    speed: 25
  });
  t.run(function (o) {
    o.output('$> ').wait(4000);
    o.output('curl -X POST -H ').wait(300);
    o.output('"Content-Type: application/json" -f').wait(200)
    o.del(3).output(' -d \'{"name": "Testing"}\'  ').wait(100);

    o.del(1).output('https://openws.org').wait(200)
    o.output('/api/collections/books').wait(200);
    o.newline();
    o.output('$> ')
  });
}

function animateSections() {
  window.sr = ScrollReveal({ duration: 500, scale: 0.9, viewFactor: 0.50, easing: 'ease-in-out', });
  sr.reveal(".prototyping");
  sr.reveal(".restful");
  sr.reveal(".open-source");
  sr.reveal(".run-locally");
}

function animateHeader() {
  var logo = document.getElementsByClassName("logo")[0];
  logo.className=logo.className + " fadeIn";
}
