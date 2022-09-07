window.addEventListener('message', (Event) => {
    const data = Event.data;
    console.log(JSON.stringify(data))
    if(data.type === 'atm-ui'){
        if (data.status){
            document.getElementById("ply_name").textContent = data.playerName;
            document.getElementById("ply_bankBalance").textContent = data.balance;
            document.getElementById("toggleView").style.display = "block";
        }
    }
});

document.getElementById("button-close").addEventListener('click', ()=> {
    console.log('Button Clicked')
    document.getElementById("toggleView").style.display = "none";
    axios.post(`https://${GetParentResourceName()}/releaseFocus`, {});
});