import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    console.log('Selection controller go!');
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
      console.error('Error:', error);  // TODO: Add some error notification
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
}
