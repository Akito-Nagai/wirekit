<template>
  <div>
    <div class="row">
      <div class="col-sm-3" v-for="lounge in lounges">
        <div class="card">
          <div class="card-block">
            <h4 class="card-title">{{ lounge.name }}</h4>
            <p class="card-text">{{ lounge.description }}</p>
            <a class="card-link" :href="hrefLounge(lounge.id)">{{ lounge.id }}</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import client from './chat_client'

  export default {
    data: {
      lounges: []
    },
    created: function () {
      client.getLounges().then(data => {
        this.lounges = data
      })
    },
    methods: {
      hrefLounge: function (id) {
        return `/admin/lounges/${id}`
      }
    }
  }

</script>
