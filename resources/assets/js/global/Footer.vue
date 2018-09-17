<template>
    <!-- start footer -->
    <v-footer height="auto">
        <v-flex xs12>
          <v-card dark color="blue darken-3" style="border-radius: 0px;">
            <v-card-text class="text-xs-center text-sm-center text-md-center text-lg-right text-xl-right">&copy;<span v-if="date_now != 2018">&nbsp;2018 -&nbsp;</span>{{ date_now }} ConfigSupTool <br />By MEL EMO</v-card-text>
          </v-card>
        </v-flex>
    </v-footer>
    <!-- end footer -->
</template>

<script>
export default {
  data() {
    return {
      date_now: new Date().getFullYear()
    };
  },
  mounted() {}
};
</script>
