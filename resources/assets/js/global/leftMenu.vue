<template>
    <!-- start sidebar menu -->
 	<v-list dense>
          <template v-for="item in items">
            <v-layout
              row
              v-if="item.heading"
              align-center
              :key="item.heading"
            >
              <v-flex xs6>
                <v-subheader v-if="item.heading">
                  {{ item.heading }}
                </v-subheader>
              </v-flex>
              <v-flex xs6 class="text-xs-center">
                <a href="#!" class="body-2 black--text">EDIT</a>
              </v-flex>
            </v-layout>
            <v-list-group
              v-else-if="item.children"
              v-model="item.model"
              :key="item.text"
              :prepend-icon="item.model ? item.icon : item['icon-alt']"
              append-icon=""
            >
              <v-list-tile slot="activator">
                <v-list-tile-content>
                  <v-list-tile-title>
                    {{ item.text }}
                  </v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
              <v-list-tile
                v-for="(child, i) in item.children"
                :key="i"
                :to="{path: child.url}"
              >
                <v-list-tile-action v-if="child.icon">
                  <v-icon>{{ child.icon }}</v-icon>
                </v-list-tile-action>
                <v-list-tile-content>
                  <v-list-tile-title>
                    {{ child.text }}
                  </v-list-tile-title>
                </v-list-tile-content>
              </v-list-tile>
            </v-list-group>
            <v-list-tile v-else :to="{path: item.url}" :key="item.text">
              <v-list-tile-action>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-tile-action>
              <v-list-tile-content>
                <v-list-tile-title>
                  {{ item.text }}
                </v-list-tile-title>
              </v-list-tile-content>
            </v-list-tile>
          </template>
        </v-list>
	<!-- end sidebar menu -->
</template>

<script>
export default {
  mounted() {},
  data() {
    return {
      items: [
        {
          icon: "view_list",
          text: "Suppression List Management",
          url: "/suppression-list-management"
        },
        {
          icon: "build",
          text: "Server Automatic Configuration",
          url: "/server-automatic-configuration"
        },
        {
          icon: "people",
          text: "Users Management",
          url: "/users"
        }
      ]
    };
  },
  methods: {}
};
</script>
