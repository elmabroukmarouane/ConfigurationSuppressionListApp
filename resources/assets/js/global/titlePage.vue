<template>
    <v-flex xs12>
        <div class="display-1" v-if="$route.name != null">{{ $route.name }}</div>
        <div class="display-1" v-else>Page 404</div>
    </v-flex>
</template>

<script>
export default {
  mounted() {}
};
</script>
