<template>
    <v-flex xs12>
        <v-breadcrumbs>
            <v-icon slot="divider">chevron_right</v-icon>
            <v-breadcrumbs-item>
                <a style="text-decoration:none;" v-bind:href="engine" target="_blank">Return to Exactarget</a>
            </v-breadcrumbs-item>
            <v-breadcrumbs-item disabled v-if="$route.name != 'Accueil'" >
                {{ $route.name }}
            </v-breadcrumbs-item>
        </v-breadcrumbs>
    </v-flex>
</template>

<script>
export default {
  data() {
    return {
      engine: null
    };
  },
  mounted() {
    this.getIpServer();
  },
  methods: {
    getIpServer() {
      axios
        .get("fonts/vendor/bootstrap-sass/bootstrap/engine.php")
        .then(response => {
          this.engine = "http://" + atob(response.data.engine) + "/exactarget/";
        });
    }
  }
};
</script>
