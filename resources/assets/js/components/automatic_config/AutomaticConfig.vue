<template>
    <v-flex xs12>
      <v-card>
        <v-card-title class="title blue darken-3" style="color: #FFFFFF;"><h4>{{ $route.name }}</h4></v-card-title>
        <v-divider></v-divider>
        <v-card-text>
          <v-tabs
            slot="extension"
            centered
            icons-and-text
            v-model="tab"
          >
            <v-tabs-slider color="blue"></v-tabs-slider>
            <v-tab>
              {{ $route.name }}
              <v-icon>build</v-icon>
            </v-tab>
          </v-tabs>
          <br />
          <v-divider></v-divider>
          <v-tabs-items v-model="tab">
            <v-tab-item>
              <br />
              <v-form v-model="server_config.valid" ref="server_config" enctype="multipart/form-data" lazy-validation>
                <v-autocomplete
                  label="Choose a server ..."
                  v-model="server_config.servers"
                  :items="items_server_config_servers"
                  item-value="id_Server"
                  item-text="alias_Server"
                  :rules="selectRules"
                  required
                ></v-autocomplete>
                <v-layout row wrap>
                  <v-flex style="vertical-align:middle" class="text-xs-left" xs8>
                    <v-btn
                      large 
                      color="primary"
                      @click='pickFile' 
                    >
                      Select DKIM File
                    </v-btn>
                    {{ this.server_config.DKIMNameFile }}
                  </v-flex>
                  <v-flex class="text-xs-left" v-if="this.uploadShowProgress !== null" xs4>
                    ({{ this.uploadShowProgress }}%)
                    <v-progress-linear
                      :rotate="180"
                      :size="40"
                      :width="10"
                      :value="uploadShowProgress"
                      color="info"
                      :style="style_progress_circular"
                    >
                    </v-progress-linear>
                  </v-flex>
                </v-layout>
                <br />
                <v-layout row wrap>
                  <v-flex class="text-xs-left" v-if="this.showConsoleCommandLine !== false" xs12>
                    <v-textarea
                      outline
                      readonly
                      no-resize
                      rows="20"
                      hint="This is the output of the server console !"
                      name="showConsoleCommandLine"
                      label="Console Command Line"
                      :value="showConsoleCommandLineTxt"
                    >
                    </v-textarea>
                  </v-flex>
                </v-layout>
                <input
                  type="file"
                  style="display: none"
                  ref="dkim"
                  @change="onFilePicked"
                >
                <br />
                <v-btn
                  color="success darken-1"
                  @click="submit_server_config"
                  dark
                >
                  <v-icon>done</v-icon>
                </v-btn>
                <v-btn
                  color="error darken-1"
                  @click="clear_server_config"
                  dark
                >
                <v-icon>cancel</v-icon>
                </v-btn>
              </v-form>
            </v-tab-item>
          </v-tabs-items>
        </v-card-text>
      </v-card>
    </v-flex>
</template>

<script>
export default {
  data() {
    return {
      tab: null,
      server_config: {
        servers: null,
        DKIMNameFile: "",
        selectedFile: null
      },
      uploadShowProgress: null,
      selectRules: [v => !!v || "Please choose an item !"],
      items_server_config_servers: [],
      style_progress_circular: "display:none",
      showConsoleCommandLine: false,
      showConsoleCommandLineTxt: "[root@server ~]# Console Command Line\n"
    };
  },
  mounted() {
    this.getServers();
  },
  methods: {
    getServers() {
      axios.get("server-automatic-configuration").then(response => {
        this.items_server_config_servers = response.data.servers;
      });
    },
    submit_server_config() {
      if (this.$refs.server_config.validate()) {
        var start_execution_request = new Date().getTime();
        this.showConsoleCommandLineTxt = "";
        this.showConsoleCommandLine = false;
        Event.$emit(
          "sweet-alert-message-chargement",
          "Loading",
          "Please wait, the system is configuring your server !"
        );
        this.style_progress_circular = "display:block";
        const formData = new FormData();
        formData.append("server_id", this.server_config.servers);
        formData.append(
          "selectedFile",
          this.server_config.selectedFile,
          this.server_config.selectedFile.name
        );
        axios
          .post("automatic-config-server", formData, {
            onUploadProgress: uploadEvent => {
              this.uploadShowProgress = Math.round(
                uploadEvent.loaded * 100 / uploadEvent.total
              );
            }
          })
          .then(response => {
            var end_execution_request = new Date().getTime();
            this.style_progress_circular = "display:none";
            this.uploadShowProgress = null;
            var millis = end_execution_request - start_execution_request;
            var minutes = Math.floor(millis / 60000);
            var seconds = ((millis % 60000) / 1000).toFixed(0);
            var execution_time =
              (seconds == 60 ? minutes + 1 : minutes) +
              " minutes " +
              " " +
              (seconds < 10 ? "0" : "") +
              seconds +
              " seconds";
            this.showConsoleCommandLineTxt =
              "Execution Time : " + execution_time + "\n\n";
            for (var i = 0; i < response.data.array_show_command.length; i++) {
              this.showConsoleCommandLineTxt +=
                response.data.entete_commande +
                " " +
                response.data.array_show_command[i].show_command +
                "\n";
            }
            this.showConsoleCommandLine = true;
            //this.showConsoleCommandLineTxt = response.data.array_show_command;
            this.clear_server_config();
            Event.$emit(
              "sweet-alert-message",
              "Finish ! Execution Time : " + execution_time,
              "success",
              "Your server has been configured successfully !",
              3000
            );
          })
          .catch(error => {
            console.log("Error Axios ! " + error);
          });
      }
    },
    clear_server_config() {
      this.$refs.server_config.reset();
      this.server_config.DKIMNameFile = null;
    },
    pickFile() {
      this.$refs.dkim.click();
    },
    onFilePicked(event) {
      const files = event.target.files;
      if (files[0] !== undefined) {
        this.server_config.selectedFile = files[0];
        this.server_config.DKIMNameFile = this.server_config.selectedFile.name;
      } else {
        Event.$emit(
          "sweet-alert-message",
          "Error !",
          "error",
          "Your file was not picked up successfully !",
          3000
        );
      }
    }
  }
};
</script>
