let activePlayerProfile

window.onload = function(){
    if(document.querySelector(".players.show")){
        fetchActiveProfilePlayerData() 
    }
}

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

class PlayerSquad {
    constructor(json) {
        this.id = json["id"]
        this.name = json["attributes"]["name"];
        this.player_count = json["attributes"]["player-count"];
        this.link = json["links"]["self"]
    }

    createElement(){
        let squadDiv = document.createElement('div')
        let squadATag = document.createElement('a')

        squadATag.href = this.link
        squadATag.innerText = `${this.name} (${this.player_count} members)`

        squadDiv.appendChild(squadATag)

        if(activePlayerProfile.isAdminOfSquad(this.id)){
            squadDiv.innerHTML += "<strong> Admin </strong>"
        }

        return squadDiv
    }
}

class PlayerGame {
    constructor(json) {
        this.id = json["id"]
        // this.name = json["attributes"]["name"];
        this.court_name = json["attributes"]["court-name"];
        this.link = json["links"]["self"]
        this.court_link = json["links"]["court"]
    }

    createElement(){
        let courtDiv = document.createElement('div')
        let courtATag = document.createElement('a')

        squadATag.href = this.link
        squadATag.innerText = `${this.name} (${this.player_count} members)`

        squadDiv.appendChild(squadATag)

        if(activePlayerProfile.isAdminOfSquad(this.id)){
            squadDiv.innerHTML += "<strong> Admin </strong>"
        }

        return squadDiv
    }
}

function fetchActiveProfilePlayerData(){
    let userId = document.querySelector('h1').getAttribute("user-id");
    fetch(`/players/${userId}.json`)
    .then(response => response.json())
    .then((json) => {
        activePlayerProfile = new Player(json)
        populatePlayerProfile(json)
    }
    );
}

function populatePlayerProfile(json){
    json["included"].forEach(function(resourceJson){
        if(resourceJson["type"] === "squads"){
            let squad = new PlayerSquad(resourceJson)
            let squadElement = squad.createElement()
            document.querySelector(".js-player-squads").appendChild(squadElement)
        }else if(resourceJson["type"] === "games"){
            let game = new PlayerGame(resourceJson)
            let gameElement = game.createElement()
            document.querySelector(".js-player-games").appendChild(gameElement)
        }
    })
}
