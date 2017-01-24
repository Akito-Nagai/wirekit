<stream>

  <p>curretAttendeeId = { cuid }</p>

  <script>
    opts.client.stream({ lounge: opts.lounge, channel: opts.channel, attendee: opts.attendee })
    this.cuid = opts.client.getCurrentAttendeeId()
  </script>

</stream>
