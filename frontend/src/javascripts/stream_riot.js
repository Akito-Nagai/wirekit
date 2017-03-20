import client from './chat_client';
require('./stream.tag');
riot.mount('stream', { client: client });
