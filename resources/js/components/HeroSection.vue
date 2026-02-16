<template>
    <section class="hero" id="hero">
        <div class="hero-mesh"></div>
        <div class="hero-shapes" ref="shapeLayer">
            <span class="floating-shape circle" style="top:10%; left:12%;" data-depth="0.15"></span>
            <span class="floating-shape hex" style="top:18%; left:75%; width:90px; height:90px;" data-depth="0.25"></span>
            <span class="floating-shape circle" style="top:60%; left:8%; width:70px; height:70px;" data-depth="0.35"></span>
            <span class="floating-shape hex" style="top:68%; left:80%; width:110px; height:110px;" data-depth="0.2"></span>
            <span class="floating-shape circle" style="top:35%; left:45%; width:50px; height:50px;" data-depth="0.3"></span>
            <span class="floating-shape hex" style="top:75%; left:30%; width:60px; height:60px;" data-depth="0.4"></span>
            <span class="floating-shape circle" style="top:22%; left:30%; width:40px; height:40px;" data-depth="0.25"></span>
            <span class="floating-shape circle" style="top:85%; left:55%; width:90px; height:90px;" data-depth="0.2"></span>
            <span class="floating-shape hex" style="top:8%; left:55%; width:70px; height:70px;" data-depth="0.35"></span>
            <span class="floating-shape circle" style="top:42%; left:85%; width:60px; height:60px;" data-depth="0.3"></span>
            <span class="floating-shape hex" style="top:50%; left:18%; width:80px; height:80px;" data-depth="0.25"></span>
            <span class="floating-shape circle" style="top:78%; left:70%; width:45px; height:45px;" data-depth="0.4"></span>
        </div>

        <div class="hero-content">
            <div class="hero-eyebrow">WEB3 INFRASTRUCTURE FOR AFRICA</div>
            <h1 class="hero-title fade-up">Africa's Blockchain <span>Backbone</span></h1>
            <p class="hero-sub fade-up delay-1">
                Licensed infrastructure connecting traditional finance to Web3 - invisible to users, indispensable to builders.
            </p>
            <div class="hero-actions fade-up delay-2">
                <a class="btn-primary" href="#cta">Build With Us</a>
                <a class="btn-outline" href="#services">Explore Infrastructure</a>
            </div>

            <div class="hero-stats">
                <div class="hero-stat-card">
                    <strong>10M+</strong>
                    <span>PROCESSED TRANSACTIONS</span>
                </div>
                <div class="hero-stat-card">
                    <strong>99.9%</strong>
                    <span>NODE UPTIME</span>
                </div>
                <div class="hero-stat-card">
                    <strong>&lt;2s</strong>
                    <span>FINALITY SPEED</span>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const shapeLayer = ref(null);
let rafId = 0;

const updateParallax = () => {
    if (!shapeLayer.value) return;
    const offset = window.scrollY * 0.08;
    shapeLayer.value.style.transform = `translate3d(0, ${offset}px, 0)`;
    rafId = requestAnimationFrame(updateParallax);
};

onMounted(() => {
    rafId = requestAnimationFrame(updateParallax);
});

onBeforeUnmount(() => {
    cancelAnimationFrame(rafId);
});
</script>
