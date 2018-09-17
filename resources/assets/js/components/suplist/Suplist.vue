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
              Download Supression File by Link
              <v-icon>cloud_download</v-icon>
            </v-tab>
            <v-tab>
              Download Supression File by Upload
              <v-icon>cloud_download</v-icon>
            </v-tab>
          </v-tabs>
          <br />
          <v-divider></v-divider>
          <v-tabs-items v-model="tab">
            <v-tab-item>
              <br />
              <v-form v-model="suplist.valid" ref="suplist_url" lazy-validation>
                <v-autocomplete
                  label="Choose a sponsor ..."
                  v-model="suplist.sponsors"
                  :items="items_sponsors"
                  item-value="id_Sponsor"
                  item-text="name_Sponsor"
                  :rules="selectRules"
                  v-on:change="getOffers"
                  required
                ></v-autocomplete>
                <v-autocomplete
                  label="Choose an offer ..."
                  v-model="suplist.offers"
                  :items="items_offers"
                  item-value="id_offer"
                  item-text="name_Offer"
                  :rules="selectRules"
                  required
                ></v-autocomplete>
                <v-text-field
                  label="Enter the Supression List URL ..."
                  v-model="suplist.url"
                  :rules="urlRules"
                  required
                ></v-text-field>
                <v-autocomplete
                  label="Is the suppression file in MD5 format ?"
                  v-model="suplist.md5"
                  :items="items_md5"
                  :rules="selectRules"
                  required
                ></v-autocomplete>
                <v-autocomplete
                  label="What is your file format ?"
                  v-model="suplist.format_file_url"
                  :items="items_format_file_url"
                  :rules="selectRules"
                  required
                ></v-autocomplete>
                
                <v-btn
                  color="success darken-1"
                  @click="submit_add"
                  dark
                >
                  <v-icon>done</v-icon>
                </v-btn>
                <v-btn
                  color="error darken-1"
                  @click="clear_add"
                  dark
                >
                <v-icon>cancel</v-icon>
                </v-btn>
              </v-form>
            </v-tab-item>
            <v-tab-item>
              <br />
              <v-form v-model="suplist_upload.valid" ref="suplist_upload" enctype="multipart/form-data" lazy-validation>
                <v-autocomplete
                  label="Choose a sponsor ..."
                  v-model="suplist_upload.sponsors"
                  :items="items_upload_sponsors"
                  item-value="id_Sponsor"
                  item-text="name_Sponsor"
                  :rules="selectRules"
                  v-on:change="getUploadOffers"
                  required
                ></v-autocomplete>
                <v-autocomplete
                  label="Choose an offer ..."
                  v-model="suplist_upload.offers"
                  :items="items_upload_offers"
                  item-value="id_offer"
                  item-text="name_Offer"
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
                      Select Supression List
                    </v-btn>
                    {{ this.suplist_upload.SuplistNameFile }}
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
                <input
                  type="file"
                  style="display: none"
                  ref="suplist"
                  accept=".gtar, .gz, .tar, .zip, .rar, .txt"
                  @change="onFilePicked"
                >
                <v-autocomplete
                  label="Is the suppression file in MD5 format ?"
                  v-model="suplist_upload.md5"
                  :items="items_upload_md5"
                  :rules="selectRules"
                  required
                ></v-autocomplete>

                <v-btn
                  color="success darken-1"
                  @click="submit_upload_add"
                  dark
                >
                  <v-icon>done</v-icon>
                </v-btn>
                <v-btn
                  color="error darken-1"
                  @click="clear_upload_add"
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
      suplist: {
        sponsors: null,
        offers: null,
        url: "",
        md5: null,
        format_file_url: null
      },
      suplist_upload: {
        sponsors: null,
        offers: null,
        SuplistNameFile: "",
        selectedFile: null,
        md5: null
      },
      urlRules: [v => !!v || "Please enter the link of the supression list !"],
      selectRules: [v => !!v || "Please choose an item !"],
      items_md5: ["Yes", "No"],
      items_format_file_url: ["Compressed", "TXT"],
      items_sponsors: [],
      items_offers: [],
      items_upload_sponsors: [],
      items_upload_offers: [],
      items_upload_md5: ["Yes", "No"],
      uploadShowProgress: null,
      style_progress_circular: "display:none"
    };
  },
  mounted() {
    this.getSponsors();
    this.getUploadSponsors();
  },
  methods: {
    getSponsors() {
      axios.get("suplist").then(response => {
        this.items_sponsors = response.data.sponsors;
      });
    },
    getOffers(id_Sponsor_Offer) {
      axios.get("get-offers/" + id_Sponsor_Offer).then(response => {
        this.items_offers = response.data.offers;
      });
    },
    getUploadSponsors() {
      axios.get("suplist").then(response => {
        this.items_upload_sponsors = response.data.sponsors;
      });
    },
    getUploadOffers(id_Sponsor_Offer) {
      axios.get("get-offers/" + id_Sponsor_Offer).then(response => {
        this.items_upload_offers = response.data.offers;
      });
    },
    submit_add() {
      if (this.$refs.suplist_url.validate()) {
        Event.$emit(
          "sweet-alert-message-chargement",
          "Loading",
          "Please wait, the system is processing your request !"
        );
        axios
          .post("suplist", {
            offers: this.suplist.offers,
            url: this.suplist.url,
            md5: this.suplist.md5,
            format_file_url: this.suplist.format_file_url
          })
          .then(response => {
            this.clear_add();
            Event.$emit(
              "sweet-alert-message",
              "Finish !",
              "success",
              "Your supression file is uploaded successfully !",
              3000
            );
          })
          .catch(error => {});
      }
    },
    clear_add() {
      this.$refs.suplist_url.reset();
    },
    submit_upload_add() {
      if (this.$refs.suplist_upload.validate()) {
        Event.$emit(
          "sweet-alert-message-chargement",
          "Loading",
          "Please wait, the system is processing your request !"
        );
        this.style_progress_circular = "display:block";
        const formData = new FormData();
        formData.append("offers", this.suplist_upload.offers);
        formData.append("md5", this.suplist_upload.md5);
        formData.append(
          "selectedFile",
          this.suplist_upload.selectedFile,
          this.suplist_upload.selectedFile.name
        );
        axios
          .post("suplist-upload", formData, {
            onUploadProgress: uploadEvent => {
              this.uploadShowProgress = Math.round(
                uploadEvent.loaded * 100 / uploadEvent.total
              );
            }
          })
          .then(response => {
            this.style_progress_circular = "display:none";
            this.uploadShowProgress = null;
            this.clear_upload_add();
            Event.$emit(
              "sweet-alert-message",
              "Finish !",
              "success",
              "Your supression file is uploaded successfully !",
              3000
            );
          })
          .catch(error => {
            console.log("Error Axios ! " + error);
          });
      }
    },
    clear_upload_add() {
      this.$refs.suplist_upload.reset();
      this.suplist_upload.SuplistNameFile = null;
    },
    pickFile() {
      this.$refs.suplist.click();
    },
    onFilePicked(event) {
      const files = event.target.files;
      if (files[0] !== undefined) {
        this.suplist_upload.selectedFile = files[0];
        this.suplist_upload.SuplistNameFile = this.suplist_upload.selectedFile.name;
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

