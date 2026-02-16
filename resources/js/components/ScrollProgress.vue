<template>
    <div class="progress-bar" :style="{ width: progress + '%' }"></div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const progress = ref(0);

const update = () => {
    const scrollTop = window.scrollY;
    const docHeight = document.documentElement.scrollHeight - window.innerHeight;
    progress.value = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
};

onMounted(() => {
    update();
    window.addEventListener('scroll', update, { passive: true });
    window.addEventListener('resize', update);
});

onBeforeUnmount(() => {
    window.removeEventListener('scroll', update);
    window.removeEventListener('resize', update);
});
</script>
