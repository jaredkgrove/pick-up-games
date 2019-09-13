// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require activestorage

//= require_tree .

window.onload = function(){
    document.getElementById("js-courts").addEventListener('click', function(e){
        e.preventDefault()
        fetchCourts()
    })
}

function emptyMain(){
    let main = document.querySelector('main')
    main.innerHTML = ''
    return main    
}

function setBodyClass(className){
    let body = document.querySelector('body')
    body.setAttribute("class", className)
}

function createElement(type = 'div', attributes = {}, text = ''){
    let elem = document.createElement(type)
    elem.textContent = text
    for(let attr in attributes) {
        elem.setAttribute(attr, attributes[attr])
    }
    return elem
}

function createLink(attributes){
    let a = document.createElement('a')
    for(let attr in attributes) {
        a.setAttribute(attr, attributes[attr])
    }
    return a
}

function createDiv(attributes){
    let div = document.createElement('div')
    for(let attr in attributes) {
        div.setAttribute(attr, attributes[attr])
    }
    return div
}