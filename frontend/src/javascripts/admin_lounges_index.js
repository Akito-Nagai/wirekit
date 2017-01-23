import client from './chat_client';
require('./lounges.tag');
riot.mount('lounges', { client: client });
