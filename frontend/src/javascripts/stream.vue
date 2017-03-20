<template>
  <p>curretAttendeeId = {{ cuid }}</p>
</template>

<script>

  import client from './chat_client'

  export default {
    props: ['lounge', 'channel', 'attendee'],
    data: {
      cuid: null
    },
    created: function () {
      client.stream({ lounge: this.lounge, channel: this.channel, attendee: this.attendee })
      this.cuid = client.getCurrentAttendeeId()
    }
  }

</script>
