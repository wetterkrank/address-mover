import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {

  initialize() {
    console.log(this.data.get("check"));
  }

  connect() {
    console.log('Selection controller go!');
  }

  // Creates the new MyProvider object with AJAX and shows some feedback
  add(event) {
    const checkIcon = this.data.get('check');
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
      providerButton.dataset.action = "click->selection#remove";
      providerButton.src = checkIcon;

    }).catch((error) => {
      console.error('Error:', error);  // TODO: Add some error message
    });
  }


  remove(event) {
    const providerID = event.target.id;
    const plusIcon = this.data.get('plus');

    fetch(`/my_providers/unselect/${providerID}`, {
      method: 'DELETE',
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
      providerButton.dataset.action = "click->selection#add";
      providerButton.src = plusIcon;

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
