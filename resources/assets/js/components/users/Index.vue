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
              Users List
              <v-icon>list</v-icon>
            </v-tab>
            <v-tab>
              Add
              <v-icon>add</v-icon>
            </v-tab>
          </v-tabs>
          <br />
          <v-divider></v-divider>
          <v-tabs-items v-model="tab">
            <v-tab-item>
              <v-card>
                <v-card-title>
                  <v-spacer></v-spacer>
                  <v-text-field
                    append-icon="search"
                    label="Search"
                    single-line
                    hide-details
                    v-model="search"
                  ></v-text-field>
                </v-card-title>
                <v-data-table
                  :headers="headers"
                  :items="users"
                  :search="search"
                  rows-per-page-text="Lines per page"
                  item-key="name"
                  class="elevation-1"
                >
                  <template slot="items" slot-scope="props">
                    <td>{{ props.item.name }}</td>
                    <td>{{ props.item.email }}</td>
                    <td>
                      <v-btn fab dark small color='orange darken-1' @click.stop="initUpdateUser(props.item.id)"><v-icon dark>edit</v-icon></v-btn>
                      <v-btn fab dark small color='error' @click.stop="initDeleteUser(props.item.id)"><v-icon dark>delete_sweep</v-icon></v-btn>
                    </td>
                  </template>
                  <template slot="pageText" slot-scope="props">
                    Lines {{ props.pageStart }} - {{ props.pageStop }} of {{ props.itemsLength }}
                  </template>
                  <v-alert slot="no-data" :value="true" color="error" icon="warning" style="text-align: center;">
                    <label>Empty Table !!!</label>
                  </v-alert>
                  <v-alert slot="no-results" :value="true" color="error" icon="warning" style="text-align: center;">
                    <label>No results were found !!!!"{{ search }}"</label>
                  </v-alert>
                </v-data-table>
              </v-card>
            </v-tab-item>
            <v-tab-item>
              <br />
              <v-form v-model="user.valid" ref="add_form" lazy-validation>
                <v-text-field
                  label="LastName & FirstName"
                  v-model="user.name"
                  :rules="nameRules"
                  required
                ></v-text-field>
                <v-text-field
                  label="Email"
                  v-model="user.email"
                  :rules="emailRules"
                  required
                ></v-text-field>
                <v-text-field 
                  label="Password" 
                  type="password" 
                  v-model="user.password" 
                  :rules="passwordRules" 
                  required
                ></v-text-field>
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
          </v-tabs-items>
        </v-card-text>
      </v-card>
      <v-dialog
        v-model="dialog"
        fullscreen
        transition="dialog-bottom-transition"
        :overlay="false"
        scrollable
      >
        <v-card tile>
          <v-toolbar card dark color="blue darken-3">
            <v-btn icon @click.native="dialog = false" dark>
              <v-icon>close</v-icon>
            </v-btn>
            <v-toolbar-title>Edit User</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form v-model="edit_user.valid" ref="edit_form" lazy-validation>
              <v-text-field
                label="LastName & FirstName"
                v-model="edit_user.name"
                :rules="nameRules"
                required
              ></v-text-field>
              <v-text-field
                label="Email"
                v-model="edit_user.email"
                :rules="emailRules"
                required
              ></v-text-field>
              <v-text-field 
                label="Password" 
                type="password" 
                v-model="edit_user.password"
              ></v-text-field>

              <v-btn
                color="success darken-1"
                @click="submit"
                dark
              >
                <v-icon>done</v-icon>
              </v-btn>
              <v-btn
                color="error darken-1"
                @click="clear"
                dark
              >
              <v-icon>cancel</v-icon>
              </v-btn>
            </v-form>
          </v-card-text>
          <div style="flex: 1 1 auto;"></div>
        </v-card>
      </v-dialog>
      <v-dialog v-model="dialog_delete" max-width="290">
        <v-card>
          <v-card-title class="title blue darken-3" style="color: #FFFFFF;">Delete User</v-card-title>
          <v-divider></v-divider>
          <v-card-text>Are you sure you want to delete this user ?</v-card-text>
          <v-divider></v-divider>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="red darken-1" fab dark small @click.native="dialog_delete = false">
              <v-icon>cancel</v-icon>
            </v-btn>
            <v-btn color="green darken-1" fab dark small @click.native="deleteUser">
              <v-icon>done</v-icon>
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
      <v-snackbar
        v-model="show_snackbar"
        :color="snackbar_color"
        :timeout="snackbar_timeout"
      >
        {{ snackbar_text }}
        <v-btn
          dark
          flat
          @click="show_snackbar = false"
        >
          Close
        </v-btn>
      </v-snackbar>
    </v-flex>
</template>

<script>
export default {
  data() {
    return {
      tab: null,
      search: "",
      dialog: false,
      dialog_delete: false,
      headers: [
        {
          text: "LastName & FirstName",
          align: "left",
          value: "name"
        },
        { text: "Email", align: "left", value: "email" },
        { text: "Actions", align: "left", value: "action" }
      ],
      users: [],
      user: {
        valid: false,
        name: "",
        email: "",
        password: ""
      },
      edit_user: {},
      nameRules: [v => !!v || "Please enter the first and last name !"],
      emailRules: [
        v => !!v || "Please enter the email !",
        v =>
          /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "Please enter a valid email !"
      ],
      passwordRules: [
        v => !!v || "Enter your password please !",
        v =>
          (v && v.length >= 6) || "The password must be at least 6 character !"
      ],
      show_snackbar: false,
      snackbar_color: null,
      snackbar_timeout: 2000,
      snackbar_text: "",
      this_deleted_user: null
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    getUsers() {
      axios.get("users").then(response => {
        this.users = response.data.users;
      });
    },
    initUpdateUser(id) {
      axios.get("users/" + id).then(response => {
        this.edit_user = response.data.user;
      });
      this.dialog = true;
    },
    submit() {
      if (this.$refs.edit_form.validate()) {
        axios
          .patch("users/" + this.edit_user.id, {
            name: this.edit_user.name,
            email: this.edit_user.email,
            password: this.edit_user.password
          })
          .then(response => {
            this.clear();
            this.dialog = false;
            var id_user_local = parseInt(this.edit_user.id);
            this.users = this.users.filter(function(el) {
              var el_id_user_local = parseInt(el.id);
              return el_id_user_local !== id_user_local;
            });
            this.users.unshift(response.data.user);
            this.snackbar_color = "success";
            this.snackbar_timeout = 2000;
            this.snackbar_text = "User edited successfully !";
            this.show_snackbar = true;
          })
          .catch(error => {
            this.snackbar_color = "error";
            this.snackbar_timeout = 4000;
            this.snackbar_text = error.response.data.msg;
            this.show_snackbar = true;
          });
      }
    },
    clear() {
      this.$refs.edit_form.reset();
    },
    submit_add() {
      if (this.$refs.add_form.validate()) {
        axios
          .post("users", {
            name: this.user.name,
            email: this.user.email,
            password: this.user.password
          })
          .then(response => {
            this.clear_add();
            this.users.unshift(response.data.user);
            this.snackbar_color = "success";
            this.snackbar_timeout = 2000;
            this.snackbar_text = "User added successfully !";
            this.show_snackbar = true;
          })
          .catch(error => {
            this.snackbar_color = "error";
            this.snackbar_timeout = 4000;
            this.snackbar_text = error.response.data.msg;
            this.show_snackbar = true;
          });
      }
    },
    clear_add() {
      this.$refs.add_form.reset();
    },
    initDeleteUser(id) {
      console.log(id);
      this.this_deleted_user = id;
      this.dialog_delete = true;
    },
    deleteUser() {
      axios
        .delete("users/" + this.this_deleted_user)
        .then(response => {
          var id_user_local = parseInt(this.this_deleted_user);
          this.users = this.users.filter(function(el) {
            var el_id_user_local = parseInt(el.id);
            return el_id_user_local !== id_user_local;
          });
          this.dialog_delete = false;
          this.snackbar_color = "success";
          this.snackbar_timeout = 2000;
          this.snackbar_text = "User deleted successfully !";
          this.show_snackbar = true;
        })
        .catch(error => {
          this.snackbar_color = "error";
          this.snackbar_timeout = 4000;
          this.snackbar_text = error.response.data.msg;
          this.show_snackbar = true;
        });
    }
  }
};
</script>
