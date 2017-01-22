import Cache from './cache';

export const appConfig = {
  apiEndPoint: 'http://localhost:5000',
  apiId: '',
  apiSecret: ''
}

export default class ChatClient {

  constructor() {
    this.cache = new Cache;
  }

  urlWithQuery(url, params={}) {
    let absoluteUrl = url;
    if (Object.keys(params).length > 0) {
      let prms = [];
      for (let key in params) {
        prms.push([key, params[key]].join('='));
      }
      absoluteUrl = [url, prms.join('&')].join('?');
    }
    return absoluteUrl;
  }

  async send(method, url, params={}, headers={}) {
    let absoluteUrl = this.urlWithQuery(url, params);
    console.log(`${method} ${absoluteUrl}`);
    headers['Accept'] = 'application/json'
    try {
      let response = await fetch(absoluteUrl, {method: method, headers: headers});
      let responseJson = await response.json();
      return responseJson;
    } catch(error) {
      alert(error);
    }
  }

  async getAccessToken() {
    let accessToken = this.cache.read('accessToken');
    if (accessToken == null) {
      let url = appConfig.apiEndPoint + '/oauth/token';
      let params = {
        grant_type: 'client_credentials',
        client_id: appConfig.apiId,
        client_secret: appConfig.apiSecret
      }
      let data = await this.send('POST', url, params);
      accessToken = data.access_token;
      this.cache.write('accessToken', accessToken, 3600);
    }
    return accessToken;
  }

  async get(options={}) {
    //let accessToken = await this.getAccessToken();
    let headers = {
    //  Authorization: 'Bearer ' + accessToken
    }
    let cacheKey = this.urlWithQuery(options.url, options.params);
    let data = this.cache.read(cacheKey);
    if (data == null) {
      data = await this.send('GET', options.url, options.params, headers);
      this.cache.write(cacheKey, data, options['ttl']);
    }
    return data;
  }

  async getRoot() {
    let root = await this.get({
      url: appConfig.apiEndPoint + '/v1',
      ttl: 600
    });
    return root;
  }

  async getLounges() {
    let root = await this.getRoot();
    let lounges = await this.get({
      url: root._links.lounges.href,
      ttl: 600
    });
    return lounges;
  }

}
