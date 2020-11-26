import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    console.log('Selection controller go!');
  }

  add(event) {
    const providerID = event.target.id;
    const newSelection = { my_provider: { provider_id: providerID } };

    fetch('/my_providers', {
      method: 'POST',
      body: JSON.stringify(newSelection),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': Rails.csrfToken(),
        'Accept': 'application/json'
      },
      credentials: 'same-origin'

    }).then(function (response) {
      return response.json();

    }).then(function (data) {
      const providerButton = document.getElementById(providerID);
      providerButton.hidden = true;

    }).catch((error) => {
      console.error('Error:', error);  // TODO: Add some error message
    });
  }

  categoryToggle(event) {
    const categoryID = event.target.id;
    const categoryCover = event.target;
    const providerList = categoryCover.nextElementSibling;
    providerList.toggleAttribute('hidden');
  }
}
