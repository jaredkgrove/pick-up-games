// class SimpleGame {
//     constructor(json) {
//         this.id = json["id"]
//         this.name = json["attributes"]["name"]
//         this.location = json["attributes"]["location"]
//         this.upcoming_game_count = json["attributes"]["upcoming-game-count"] 
//         this.path = json["links"]["self"]
//     }

//     createCourtWrapper(){
//         let wrapper = createLink({class: "content-box js-court", href: "#", court_id: this.id})
//         let courtNameTag = createElement('h3',{}, this.name)
//         wrapper.appendChild(courtNameTag)
//         wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
//         this.addClickListener(wrapper)
//         return wrapper
//     }

//     addClickListener(elem){
//         elem.addEventListener('click', function(e){
//             e.preventDefault()
//             fetchCourt(e.target.getAttribute('court_id'))
//         })
//     }
// }

// class CompleteGame {
//     constructor(json) {
//         this.id = json["id"]
//         this.name = json["attributes"]["name"]
//         this.location = json["attributes"]["location"]
//         this.upcoming_game_count = json["attributes"]["upcoming-game-count"] 
//         this.path = json["links"]["self"]
//     }

//     createCourtWrapper(){
//         let wrapper = createLink({class: "content-box js-court", href: "#", court_id: this.id})
//         let courtNameTag = createElement('h3',{}, this.name)
//         wrapper.appendChild(courtNameTag)
//         wrapper.innerHTML += `${this.location} <br> ${this.upcoming_game_count} upcoming games`
//         this.addClickListener(wrapper)
//         return wrapper
//     }

//     addClickListener(elem){
//         elem.addEventListener('click', function(e){
//             e.preventDefault()
//             fetchCourt(e.target.getAttribute('court_id'))
//         })
//     }
// }