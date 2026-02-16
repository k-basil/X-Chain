<template>
    <div class="loader" :class="{ hidden: !isVisible }">
        <div class="loader-logo">
            <img :src="loaderLogo" alt="X-Chain Technology Ltd." />
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import loaderLogo from '../assets/xchain-loader.png';

const isVisible = ref(true);

onMounted(() => {
    setTimeout(() => {
        isVisible.value = false;
    }, 2000);
});
</script>
