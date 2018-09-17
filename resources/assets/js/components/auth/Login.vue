<template>
    <v-container fluid fill-height>
        <v-layout align-center justify-center>
        <v-flex xs12 sm8 md4>
            <v-card class="elevation-12">
            <v-toolbar dark color="primary">
                <v-toolbar-title>ConfigSupTool</v-toolbar-title>
                <v-spacer></v-spacer>
            </v-toolbar>
            <v-form v-model="valid" ref="form" lazy-validation>
            <v-card-text>
                    <v-alert :type="color_alert" :value="true">
                        {{ msg_login_success }}
                    </v-alert>
                    <v-text-field autofous="true" prepend-icon="person" name="login" label="Email" type="text" v-model="email" :rules="emailRules" @keyup.enter="login()" required></v-text-field>
                    <v-text-field prepend-icon="lock" name="password" label="Password" id="password" type="password" v-model="password" :rules="passwordRules" @keyup.enter="login()" required></v-text-field>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" @click="login()" :disabled="!valid">Login</v-btn>
            </v-card-actions>
            </v-form>
            </v-card>
        </v-flex>
        </v-layout>
    </v-container>
</template>

<script>
export default {
  data() {
    return {
      color_alert: "info",
      msg_login_success: "Please enter your Email and password !",
      errors: [],
      valid: false,
      email: "",
      emailRules: [
        v => !!v || "Enter your Email Please !",
        v =>
          /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "Enter a valid Email please !"
      ],
      password: "",
      passwordRules: [
        v => !!v || "Enter your password please !",
        v =>
          (v && v.length >= 6) || "The password must be at least 6 character !"
      ]
    };
  },
  mounted() {},
  methods: {
    login() {
      if (this.$refs.form.validate()) {
        axios
          .post("login", {
            email: this.email,
            password: this.password
          })
          .then(response => {
            this.color_alert = "success";
            this.msg_login_success = response.data.msg;
            setTimeout(this.redirectFunction, 1000);
          })
          .catch(error => {
            this.$refs.form.reset();
            this.color_alert = "error";
            this.msg_login_success = error.response.data.msg;
          });
      }
    },
    redirectFunction() {
      this.$router.push({ path: "/suppression-list-management" });
    }
  }
};
</script>
