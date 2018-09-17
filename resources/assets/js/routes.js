import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

function checkserverip(to, from, next) {
  if (to.path !== "/server-ip-check") {
    axios.get("fonts/vendor/bootstrap-sass/bootstrap/engine.php").then(response => {
      if (atob(response.data.engine) === "::1") {
        if (to.name !== "Login") {
          axios.get("is-logged").then(response => {
            if (response.data.auth_check == true) {
              next();
            } else {
              next({
                path: "/auth/login"
              });
            }
          });
        }
      } else {
        next({
          path: "/check/server-ip-check"
        });
      }
    });
  } else {
    next({
      path: "/check/server-ip-check"
    });
  }
}

const routes = [{
    path: "/",
    component: require("./components/layouts/LayoutApp.vue"),
    beforeEnter: checkserverip,
    beforeRouteEnter: checkserverip,
    children: [{
        name: "Suppression List Management",
        path: "/suppression-list-management",
        component: require("./components/suplist/Suplist.vue")
      },
      {
        name: "Server Automatic Configuration",
        path: "/server-automatic-configuration",
        component: require("./components/automatic_config/AutomaticConfig.vue")
      },
      {
        name: "Users Management",
        path: "/users",
        component: require("./components/users/Index.vue")
      }
    ]
  },
  {
    path: "/auth",
    component: require("./components/layouts/LayoutLogin.vue"),
    children: [{
      name: "Login",
      path: "login",
      component: require("./components/auth/Login.vue")
    }]
  },
  {
    path: "/check",
    component: require("./components/layouts/LayoutApp.vue"),
    children: [{
      name: "Server IP Check",
      path: "server-ip-check",
      component: require("./components/serveripcheck/ServerIpCheck.vue")
    }]
  }
];

export const router = new VueRouter({
  routes
});
export default router;