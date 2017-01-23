<loungeAttendees>

  <ul class="col-sm-3" each={ attendees }>
    <li>{ uuid }</li>
  </ul>

  <script>
    opts.client.getLoungeAttendees(opts.lounge).then(data => {
      this.attendees = data
      this.update()
    })
  </script>

</loungeAttendees>
