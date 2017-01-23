import client from './chat_client';
require('./lounge_attendees.tag');
riot.mount('loungeAttendees', { client: client });
