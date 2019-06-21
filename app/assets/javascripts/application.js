// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require tinymce
//= require chartkick
//= require Chart.bundle
//= require_tree .

$(document).ready(function() {
    // Form submission
    let form = document.querySelector('form');
    
    form.addEventListener('submit', (event) => {
        $('form .actions > .btn.btn-block').hide();
        
        let loader = document.createElement('button');
        loader.setAttribute('class', 'btn btn-primary btn-block');
        loader.setAttribute('disabled', 'true');
        loader.innerHTML = `<div class="spinner-grow text-light" role="status"></div>`;
        
        document.querySelector('form .actions')
        .appendChild(loader);
    });
    
    displayBar = (elem) => {
        elem.lastElementChild.classList.toggle('full-width');
    }
});