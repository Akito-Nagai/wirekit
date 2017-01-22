import ChatClient from './chat_client';

require('./lounges.tag');

riot.mount('*', { client: new ChatClient });
