import RestClient from './rest_api_client';
import cookie from 'cookie/index.js';

export const appConfig = {
  apiEndPoint: 'http://localhost:5000',
  apiId: '',
  apiSecret: ''
}

export class ChatClient extends RestClient {

  async getRoot() {
    let root = await this.get({
      url: appConfig.apiEndPoint + '/v1',
      ttl: 1000
    });
    return root;
  }

  async getLounges() {
    let root = await this.getRoot();
    let lounges = await this.get({
      url: root._links.lounges.href,
      ttl: 10
    });
    return lounges;
  }

  async getLounge(loungeId) {
    let root = await this.getRoot();
    let lounge = await this.get({
      url: root._links.lounges.href + '/' + loungeId,
      ttl: 10
    });
    return lounge;
  }

  async getLoungeAttendees(loungeId) {
    let lounge = await this.getLounge(loungeId);
    let loungeAttendees = await this.get({
      url: lounge._links.attendees.href,
      ttl: 10
    });
    return loungeAttendees;
  }

  async enterLounge(loungeId) {
    let lounge = await this.getLounge(loungeId);
    let attendee = await this.post({
      url: lounge._links.attendees.href
    });
    return attendee;
  }

  async leaveLounge(loungeId) {
  }

  async stream(options = {}) {
    //if (options.lounge) {
    //  let attendee = await this.enterLounge(options.lounge);
    //}
    let root = await this.getRoot();
    let url = this.urlWithQuery(root._links.stream.href,
      { lounge: options.lounge, channel: options.channel });
    let sse = new EventSource(url);
    sse.onmessage = function(event) {
      alert(event)
    }
  }

  getCurrentAttendeeId() {
    let cookieData = cookie.parse(document.cookie);
    cookieData.cuid;
  }

}

export default new ChatClient();
