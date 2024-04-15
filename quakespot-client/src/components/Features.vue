<template>

    <div>
        <h1>
            Consultar eventos sísmicos
        </h1>
        <form>
            <label for="page">Página:</label>
            <input type="number" v-model="page">
            <br>
            <label for="per_page">N° de elementos por página: </label>
            <input type="number" v-model="per_page" >
            <br>

            <label for="md">md</label>            
            <input type="checkbox" v-model="md">

            <label for="ml">ml</label>            
            <input type="checkbox" v-model="ml">

            <label for="ms">ms</label>            
            <input type="checkbox" v-model="ms">

            <label for="mw">mw</label>            
            <input type="checkbox" v-model="mw">

            <label for="me">me</label>            
            <input type="checkbox" v-model="me">

            <label for="mi">mi</label>            
            <input type="checkbox" v-model="mi">

            <label for="mb">mb</label>            
            <input type="checkbox" v-model="mb">

            <label for="mlg">mlg</label>            
            <input type="checkbox" v-model="mlg">

            <br>
            <button type="button" @click="getFeatures">Consultar</button>
        </form>
        <div id="results">
            <div v-show="earthquakeData.length > 0">
                <table>
                    <thead>
                        <tr>
                            <th>id</th>
                            <th>Lugar</th>
                            <th>Fecha (zona horaria de usuario)</th>
                            <th>Magnitud</th>
                            <th>Tipo de Magnitud</th>
                            <th>id externa</th>
                            <th>URL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="feature in earthquakeData">
                            <td>{{ feature.id }}</td>
                            <td>{{ feature.attributes.place }}</td>
                            <td>{{ new Date(parseInt(feature.attributes.time)).toLocaleString() }}</td>
                            <td>{{ feature.attributes.magnitude }}</td>
                            <td>{{ feature.attributes.mag_type }}</td>
                            <td>{{ feature.attributes.external_id }}</td>
                            <td>{{ feature.attributes.links.external_url }}</td>
                        </tr>
                    </tbody>
                </table>

            </div>
        </div>
    </div>

</template>

<script setup>

import { ref } from 'vue'

const page = ref('1')
const per_page = ref('20')

const md = ref('true')
const ms = ref('true')
const ml = ref('true')
const mw = ref('true')
const me = ref('true')
const mi = ref('true')
const mb = ref('true')
const mlg = ref('true')

const API_URL = "http://localhost:3000/api/features"
const earthquakeData = ref([])

const getFeatures = async() => {

    const mag_types = generateString(md.value, ml.value, ms.value, mw.value, me.value, mi.value, mb.value, mlg.value)

    const queryParams = new URLSearchParams({
        page: page.value,
        per_page: per_page.value,
        mag_type: mag_types
    })

    const res = await fetch(API_URL + "?" + queryParams, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })

    const data = await res.json()
    earthquakeData.value = data.data
}

function generateString(md, ml, ms, mw, me, mi, mb, mlg) {
    const values = ["md", "ml", "ms", "mw", "me", "mi", "mb", "mlg"].filter(v => eval(v));
    return values.join(",");
}

</script>

<style scoped>
input{
    margin: .25em;
}
label{
    margin-left: 1em;
}
</style>