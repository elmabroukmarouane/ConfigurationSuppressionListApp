<template>
    <v-app id="inspire" class="div_login" style="background-image: url('img/background_it_web.jpg'); background-size: 100% 100%;">
        <v-content>
            <router-view></router-view>
        </v-content>
    </v-app>
</template>

<script>
export default {
  mounted() {}
};
</script>
<style>
.div_login::before {
  background-color: rgba(255, 255, 255, 0.37);
  content: "";
  display: block;
  height: 100%;
  position: absolute;
  width: 100%;
}
</style>
