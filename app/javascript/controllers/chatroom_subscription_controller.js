import { Controller } from "@hotwired/stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  // we need this ID to listen to the correct channel
  static values = { chatroomId: Number };
  // need this div to insert the message
  static targets = ["messages"];

  connect() {
    // the browser is now listening to this one channel
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: (data) => {
          console.log(data);
          // insert the 'data' into the messages container
          // the data should be a stringified HTML
          this.messagesTarget.insertAdjacentHTML("beforeend", data);
          // this.messagesTarget.insertAdjacentHTML("beforeend", '<p>A String HTML</p>');
        },
      }
    );
    console.log(
      `Subscribe to the chatroom with the id ${this.chatroomIdValue}.`
    );
    // Now I can access my messages div by doing:
    this.messagesTarget;
  }
}
