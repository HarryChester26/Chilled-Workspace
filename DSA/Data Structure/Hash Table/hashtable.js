let user = {
    age: 54,
    name: "Henry",
    magic: true,
    scream: function(){
        console.log("ahhhhhh!");
    }
}

user.age // O(1)
user.spell = "abra kadabra"; // O(1)
user.scream(); // O(1)

class HashTable{
    constructor(size){
        this.data = new Array(size);
    }

    _hash(key){
        let hash = 0
        for(let i = 0; i < key.length; i++){
            hash = (hash + key.charCodeAt(i) * i) % this.data.length
        }
        return hash;
    }
}

const myHashTable = new HashTable(50)
myHashTable._hash('grapes')



