require("./bootstrap");

window.Vue = require("vue");
window.Event = new Vue();

import Vuetify from "vuetify";
import swal from 'sweetalert2';
Vue.use(Vuetify);

require("./global");
require("./parts");

Vue.component("app", require("./components/App.vue"));

import {
    router
} from "./routes.js";

const app = new Vue({
    el: "#app",
    router,
    data() {
        return {
            table: "",
            drawer: null
        };
    },
    created() {
        Event.$on('sweet-alert-message', (title, icon, message, timer) => {
            this.sweetAlertMessage(title, icon, message, timer);
        });
        Event.$on('sweet-alert-message-chargement', (title, message) => {
            this.sweetAlertMessageLoading(title, message);
        });
    },
    methods: {
        sweetAlertMessage(title, icon, message, timer) {
            let timerInterval;
            swal({
                title: title,
                html: message + '<br />I will be closed in <strong></strong> seconds.',
                type: icon,
                timer: timer,
                allowOutsideClick: false,
                onOpen: () => {
                    swal.showLoading();
                    timerInterval = setInterval(() => {
                        swal.getContent().querySelector('strong')
                            .textContent = Math.round(swal.getTimerLeft() / 1000) + 1;
                    }, 100)
                },
                onClose: () => {
                    clearInterval(timerInterval);
                }
            }).then((result) => {
                if (
                    // Read more about handling dismissals
                    result.dismiss === swal.DismissReason.timer
                ) {}
            });
        },
        sweetAlertMessageLoading(title, message) {
            swal({
                title: title,
                text: message,
                onOpen: () => {
                    swal.showLoading();
                },
                allowOutsideClick: false
            });
        },
    }
});