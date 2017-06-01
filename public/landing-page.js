document.addEventListener("DOMContentLoaded", function() {
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

  function attachEvents() {
    document.getElementById('go').addEventListener('click', function() {
      openCollection();
    });

    document.getElementById('collection-name').addEventListener('keyup', function(e) {
      if(e.keyCode == 13) {
        openCollection();
      }
    });
  }

  function openCollection() {
    var collName = document.getElementById('collection-name');
    if(collName.value.length > 0) {
      window.open('https://openws.org/api/collections/' + collName.value);
    } else {
      alert('Please, inform a collection name.');
    }
  }

  function focusOnTextbox() {
    document.getElementById('collection-name').focus();
  }

  initTerminal();
  animateHeader();
  animateSections();
  attachEvents();
  focusOnTextbox();
});
