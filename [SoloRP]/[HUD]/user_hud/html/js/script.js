window.addEventListener('message', (Event) => {
    const data = Event.data;

    if(data.type === 'circleData'){
        var playerHealth = data.hp /2 + ',100';
        var playerArmor = data.ap + ',100';
        var playerStamina = data.stamina + ',100';
        var playerOxygen = data.oxygen*10 + ',100';

        if (playerOxygen == '100,100') {
            document.getElementById('circleOxygenIsHidden').style.display = "none";
        } else {
            document.getElementById('circleOxygenIsHidden').style.display = "block";
        }
        if (playerArmor == '0,100') {
            document.getElementById('circleArmorIsHidden').style.display = "none";
        } else {
            document.getElementById('circleArmorIsHidden').style.display = "block";
        }

        document.getElementById('circleHealth').setAttribute('stroke-dasharray', playerHealth);
        document.getElementById('circleArmor').setAttribute('stroke-dasharray', playerArmor);
        document.getElementById('circleStamina').setAttribute('stroke-dasharray', playerStamina);
        document.getElementById('circleOxygen').setAttribute('stroke-dasharray', playerOxygen);

    }
});