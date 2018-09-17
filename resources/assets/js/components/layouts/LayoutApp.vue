<template>
    <v-app id="inspire">
      <v-navigation-drawer
        fixed
        :clipped="$vuetify.breakpoint.lgAndUp"
        app
        v-model="drawer"
        v-if="$route.name != 'Server IP Check'"
      >
        <v-toolbar flat class="transparent">
          <v-list class="pa-0">
            <v-list-tile avatar>
              <v-list-tile-avatar>
                <img src="img/avatar_user.png">
              </v-list-tile-avatar>
              <v-list-tile-content>
                <v-list-tile-title>{{ this.name_user }}</v-list-tile-title>
              </v-list-tile-content>
              <v-list-tile-action>
                <v-btn icon @click.stop="drawer = !drawer">
                  <v-icon>chevron_left</v-icon>
                </v-btn>
              </v-list-tile-action>
            </v-list-tile>
          </v-list>
        </v-toolbar>
        <v-divider></v-divider>
        <global-left-menu></global-left-menu>
      </v-navigation-drawer>
      <v-toolbar
        color="blue darken-3"
        dark
        app
        :clipped-left="$vuetify.breakpoint.lgAndUp"
        fixed
      >
        <v-toolbar-title style="width: 300px" class="ml-0 pl-3">
          <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
          <span class="hidden-sm-and-down"><label>ConfigSupTool</label></span>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-menu open-on-hover bottom offset-y origin="center center" transition="scale-transition">
          <v-btn slot="activator" icon large>
            <v-avatar size="32px" tile>
              <img
                src="img/logo.png"
                alt="ConfigSupTool"
              >
            </v-avatar>
          </v-btn>
          <v-list>
            <v-list-tile avatar>
              <v-list-tile-avatar>
                <img src="img/avatar_user.png">
              </v-list-tile-avatar>
              <v-list-tile-content>
                <v-list-tile-title>{{ this.name_user }}</v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
            <v-divider></v-divider>
            <v-list-tile @click.stop="dialog_logout = true">
              <v-list-tile-title>
                <v-icon>power_settings_new</v-icon>
                Logout
              </v-list-tile-title>
            </v-list-tile>
          </v-list>
        </v-menu>
      </v-toolbar>
      <v-content>
        <v-container>
          <v-layout row wrap>
            <global-title-page></global-title-page>
            <global-breadcrumb-menu></global-breadcrumb-menu>
            <v-flex xs12>
              <router-view></router-view>
            </v-flex>
          </v-layout>
        </v-container>
      </v-content>
      <global-footer></global-footer>
      <v-dialog v-model="dialog_logout" max-width="290">
        <v-card>
          <v-card-title class="title blue darken-3" style="color: #FFFFFF;">Logout</v-card-title>
          <v-divider></v-divider>
          <v-card-text>Are you sure you want to quit the platform ?</v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red darken-1" fab dark small @click.native="dialog_logout = false">
              <v-icon>cancel</v-icon>
            </v-btn>
            <v-btn color="green darken-1" fab dark small @click.native="logout()">
              <v-icon>done</v-icon>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
  </v-app>
</template>

<script>
export default {
  props: {
    source: String
  },
  data() {
    return {
      tab: null,
      dialog_logout: false,
      drawer: null,
      name_user: null
    };
  },
  mounted() {
    this.getNameUser();
  },
  methods: {
    getNameUser() {
      axios.get("is-logged").then(response => {
        this.name_user = response.data.name_user;
      });
    },
    logout() {
      axios.get("logout").then(response => {
        location.reload();
      });
    }
  }
};
</script>
