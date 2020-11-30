import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    console.log('Selection controller go!');
    
    this.getProvidersList();
  }

  // Creates the new MyProvider object with AJAX and shows some feedback
  toggle(event) {
    const provider = event.currentTarget;
    const checked = provider.classList.contains("checked");

    const url = this.setUrl(checked, provider);
    const params = this.setParams(checked, provider);
    
    fetch(url, params)
    .then(function (response) {
      return response.json(); })

    .then(function (data) {
      provider.classList.toggle("checked"); })

    .catch((error) => {
      console.error('Error:', error);
      provider.classList.add("error");
    });
  }

  setUrl(checked, provider) {
    return (checked ? `/my_providers/unselect/${provider.id}` : '/my_providers');
  }

  setParams(checked, provider) {
    return {
      method: (checked ? 'DELETE' : 'POST'),
      body: (checked ? '' : JSON.stringify({ my_provider: { provider_id: provider.id } })),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
        'Accept': 'application/json'
      },
      credentials: 'same-origin'
    }
  }

  categoryToggle(event) {
    const categoryID = event.target.id;
    const categoryCover = event.target;
    const providerList = categoryCover.nextElementSibling;
    providerList.toggleAttribute('hidden');
  }

  getProvidersList() {
    const params = {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
        'Accept': 'application/json'
      },
      credentials: 'same-origin'
    };

    const url = '/providers';
      
    fetch(url, params)
    .then(response => response.json())
    .then((data) => {  
      let providerList = [];
        for( let entry in data ){
          const provider = data[entry];
          const providerName = provider.name;
          providerList.push(providerName);
        }
      const options = { data: providerList };
      console.log(options)
      $("#autocomplete").easyAutocomplete(options);
    });
  }
}
