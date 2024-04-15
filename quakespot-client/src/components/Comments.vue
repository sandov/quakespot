<template>
    <div>
        <h1>Enviar comentarios</h1>
        <form>
            <label for="body">Ingresar comentario:</label>
            <input type="text" v-model="body" id="body">
            <br>
            <label for="feature_id">id del evento:</label>
            <input type="number" v-model="feature_id" id="feature_id" >
            <br>
            <button type="button" @click="sendComment">Enviar comentario</button>
        </form>
        
        <div id="response_summary">{{ ui_response_data.success}}</div>
        <div id="response_detail">{{ ui_response_data.response_string}}</div>
    </div>
</template>

<script setup>

import { ref } from 'vue'

var ui_response_data = ref({})
const feature_id = ref('')
const body = ref('')


const API_BASE_URL = "http://localhost:3000/api/features/"

const sendComment = async() => {
    const res = await fetch(API_BASE_URL + feature_id.value + "/comments", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            "body": body.value
        })
    });

    var response = await res.json()

    const status = res.status;

    ui_response_data.value = {
        "success": (status == 201) ? "Comentario enviado exitosamente:": "Error:",
        "response_string": JSON.stringify(response)
    }
}



</script>
