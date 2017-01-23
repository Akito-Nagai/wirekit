import Cache from './cache';

export default class RestApiClient {

  constructor() {
    this.cache = new Cache;
  }

  urlWithQuery(url, params = {}) {
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

  async send(options = {}) {
    let absoluteUrl = this.urlWithQuery(options.url, options.params);
    console.log(`${options.method} ${absoluteUrl}`);
    try {
      let response = await fetch(absoluteUrl, {
        method: options.method || 'GET',
        headers: Object.assign(options.headers, { Accept: 'application/json' }),
        body: options.body
      });
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
      let data = await this.send('POST', url, { params: params });
      accessToken = data.access_token;
      this.cache.write('accessToken', accessToken, 3600);
    }
    return accessToken;
  }

  async defaultRequestHeaders() {
    // return { Authorization: 'Bearer ' + await this.getAccessToken() };
    return {};
  }

  async get(options = {}) {
    let headers = await this.defaultRequestHeaders();
    let cacheKey = this.urlWithQuery(options.url, options.params);
    let data = this.cache.read(cacheKey);
    if (data == null) {
      data = await this.send({
        method: 'GET',
        url: options.url,
        params: options.params,
        headers: headers
      });
      this.cache.write(cacheKey, data, options['ttl']);
    }
    return data;
  }

  async post(options = {}) {
    let headers = await this.defaultRequestHeaders();
    data = await this.send({
      method: 'POST',
      url: options.url,
      params: options.params,
      headers: headers
    });
    return data;
  }

}
