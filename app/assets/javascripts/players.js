// let activePlayerProfile

// window.onload = function(){
//     if(document.querySelector(".players.show")){
//         fetchActiveProfilePlayerData() 
//     }
// }
//let currentUser
class Player {
    constructor(json) { 
        this.id = json["data"]["id"]
        this.name = json["data"]["attributes"]["name"]
        this.adminSquadsJson = json["data"]["relationships"]["admin-squads"]["data"]
    }

    isAdminOfSquad(squadId){
        let admin = false
        for(let adminSquad of this.adminSquadsJson){
            if(adminSquad["id"] === squadId){
                admin = true
            }
        }
        return admin
    }
}

// // class PlayerSquad {
// //     constructor(json) {
// //         this.id = json["id"]
// //         this.name = json["attributes"]["name"];
// //         this.player_count = json["attributes"]["player-count"];
// //         this.link = json["links"]["self"]
// //     }

// //     createElement(){
// //         let squadDiv = document.createElement('div')
// //         let squadATag = document.createElement('a')

// //         squadATag.href = this.link
// //         squadATag.innerText = `${this.name} (${this.player_count} members)`

// //         squadDiv.appendChild(squadATag)

// //         if(activePlayerProfile.isAdminOfSquad(this.id)){
// //             let strongAdminTag = document.createElement('STRONG')
// //             strongAdminTag.textContent = " Admin"
// //             squadDiv.appendChild(strongAdminTag)
// //         }

// //         return squadDiv
// //     }
// // }

// class PlayerGame {
//     constructor(json) {
//         this.id = json["id"]
//         this.court_name = json["attributes"]["court-name"];
//         this.time_text = json["attributes"]["time-text"]
//         this.link = json["links"]["self"]
//         this.court_link = json["links"]["court"]
//     }

//     createElement(){
//         let gameDiv = document.createElement('div')
//         let courtATag = document.createElement('a')
//         let gameATag = document.createElement('a')

//         let formTag = document.createElement("form")
//         formTag.setAttribute('class',"button_to");
//         formTag.setAttribute('method',"post");
//         formTag.setAttribute('action',this.link);

//         let i = document.createElement("input"); //input element, text
//         i.setAttribute('type',"hidden");
//         i.setAttribute('name',"_method");
//         i.setAttribute('value',"patch");
        
//         courtATag.href = this.court_link
//         courtATag.innerText = this.court_name

//         gameATag.href = this.link
//         gameATag.innerText = this.time_text

//         let strongTag = document.createElement('h4')
//         strongTag.appendChild(courtATag)
        
//         gameDiv.appendChild(strongTag)

//         let button = this.createButtonForm()

//         gameDiv.appendChild(button)

//         gameDiv.appendChild(gameATag)

//         return gameDiv
//     }

//     createButtonForm(){
//         let form = document.createElement('form')
//         form.setAttribute("class", "button_to")
//         form.setAttribute("method", "post")
//         form.setAttribute("action", this.link)
         
//         let hiddenInput = document.createElement('input')
//         hiddenInput.setAttribute("type", "hidden")
//         hiddenInput.setAttribute("name", "_method")
//         hiddenInput.setAttribute("value", "patch")
 
//         let submitInput = document.createElement('input')
//         submitInput.setAttribute("type", "submit")
//         submitInput.setAttribute("value", "LEAVE")
 
//         let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
 
//         let tokenInput = document.createElement('input')
//         tokenInput.setAttribute("type", "hidden")
//         tokenInput.setAttribute("name", "authenticity_token")
//         tokenInput.setAttribute("value", token)
 
//         let playerInput = document.createElement('input')
//         playerInput.setAttribute("type", "hidden")
//         playerInput.setAttribute("name", "player_id")
//         playerInput.setAttribute("value", activePlayerProfile.id)
 
//         form.appendChild(hiddenInput)
//         form.appendChild(submitInput)
//         form.appendChild(tokenInput)
//         form.appendChild(playerInput)
//         return form
//     }
// }

// function fetchActiveProfilePlayerData(){
//     let userId = document.querySelector('h1').getAttribute("user-id");
//     fetch(`/players/${userId}.json`)
//     .then(response => response.json())
//     .then((json) => {
//         activePlayerProfile = new Player(json)
//         populatePlayerProfile(json)
//     }
//     );
// }

// function populatePlayerProfile(json){
//     json["included"].forEach(function(resourceJson){
//         // if(resourceJson["type"] === "squads"){
//         //     let squad = new PlayerSquad(resourceJson)
//         //     let squadElement = squad.createElement()
//         //     document.querySelector(".js-player-squads").appendChild(squadElement)
//         // }else if(resourceJson["type"] === "games"){
//         if(resourceJson["type"] === "games"){
//             let game = new PlayerGame(resourceJson)
//             let gameElement = game.createElement()
//             document.querySelector(".js-player-games").appendChild(gameElement)
//         }
//     })
// }
