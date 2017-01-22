<lounges>

  <div class="row">
    <div class="col-sm-3" each={ lounges }>
      <div class="card">
        <div class="card-block">
          <h4 class="card-title">{ name }</h4>
          <p class="card-text">{ description }</h4>
          <a class="card-link" href="/admin/lounges/{ id }">Go</a></li>
        </div>
      </div>
    </div>
  </div>

  <script>
    opts.client.getLounges().then(data => {
      this.lounges = data
      this.update()
    })
  </script>

</lounges>
