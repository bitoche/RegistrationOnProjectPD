
<script>
    function showRequests(){
        var inteamRequestsContainer = document.getElementById('in-teamRequestsContainer');
        var inteamRequestsButton = document.getElementById('in-teamRequestsButton');
        inteamRequestsContainer.classList.toggle('hidden');
        inteamRequestsButton.classList.toggle('disabled');
    }
    function confirmRequest(requestId){
        if (confirm('Вы действительно хотите добавить пользователя в эту группу?')){
            document.location.href="/team/confirmRequest/"+requestId;
        }
    }
    function cancelRequest(requestId){
        if (confirm('Вы действительно хотите отказаться добавлять пользователя в эту группу?')){
            document.location.href="/team/cancelRequest/"+requestId;
        }
    }
</script>