<template>
    <div class="cursor" :class="{ 'is-hover': isHover }"></div>
    <div class="cursor-ring" :class="{ 'is-hover': isHover }"></div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const isHover = ref(false);
let rafId = 0;
let cursorX = 0;
let cursorY = 0;
let ringX = 0;
let ringY = 0;
let targetX = 0;
let targetY = 0;
let enabled = true;

const animate = () => {
    if (!enabled) return;
    cursorX += (targetX - cursorX) * 0.2;
    cursorY += (targetY - cursorY) * 0.2;
    ringX += (targetX - ringX) * 0.1;
    ringY += (targetY - ringY) * 0.1;

    const cursor = document.querySelector('.cursor');
    const ring = document.querySelector('.cursor-ring');
    if (cursor && ring) {
        cursor.style.left = `${cursorX}px`;
        cursor.style.top = `${cursorY}px`;
        ring.style.left = `${ringX}px`;
        ring.style.top = `${ringY}px`;
    }

    rafId = requestAnimationFrame(animate);
};

const onMove = (event) => {
    targetX = event.clientX;
    targetY = event.clientY;
};

const onEnter = () => {
    isHover.value = true;
};

const onLeave = () => {
    isHover.value = false;
};

onMounted(() => {
    const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    const coarsePointer = window.matchMedia('(pointer: coarse)').matches;
    enabled = !(prefersReduced || coarsePointer);
    if (!enabled) return;
    document.addEventListener('mousemove', onMove);
    document.querySelectorAll('a, button').forEach((el) => {
        el.addEventListener('mouseenter', onEnter);
        el.addEventListener('mouseleave', onLeave);
    });
    rafId = requestAnimationFrame(animate);
});

onBeforeUnmount(() => {
    document.removeEventListener('mousemove', onMove);
    document.querySelectorAll('a, button').forEach((el) => {
        el.removeEventListener('mouseenter', onEnter);
        el.removeEventListener('mouseleave', onLeave);
    });
    cancelAnimationFrame(rafId);
});
</script>
