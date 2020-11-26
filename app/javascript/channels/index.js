// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)


const input = document.querySelector('#submit');
input.addEventListener('click', (event) => {
    const input_informations = document.querySelectorAll('.input_information');
    console.log(input_informations)
    const cleanedData = [...input_informations].map( input_information => input_information.innerHTML)
    console.log(cleanedData)
    const data = {
    informations: cleanedData
    }
    const xhr = $.ajax({
        url: 'http://localhost:3000/savemove',
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function(data, textStatus, jqXHR) {
            alert('Success!');
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert('Error occurred!');
        // Do something with the response
        }
    })
    console.log(xhr)
});