window.addEventListener('message', (Event) => {
    const data = Event.data;
    if(data.type === 'ui'){
        if (data.status){
            document.getElementById("toggleView").style.display = "block";
        }
    }
});

document.getElementById("button-cancel").addEventListener('click', ()=> {
    document.getElementById("toggleView").style.display = "none";
    axios.post(`https://${GetParentResourceName()}/releaseFocus`, {});
});