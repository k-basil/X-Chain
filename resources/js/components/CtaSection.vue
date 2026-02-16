<template>
    <section class="cta-section" id="cta" ref="ctaRef" :class="{ 'is-active': isActive }">
        <div class="particle-field" ref="particleRef"></div>
        <div class="cta-content" ref="contentRef">
            <div class="cta-eyebrow">Ready to Build?</div>
            <h2 class="cta-title">Your Infrastructure Awaits</h2>
            <p class="cta-copy">
                Join global exchanges, fintechs, and developers building on Africa's most trusted blockchain infrastructure.
            </p>
            <div class="cta-actions">
                <a class="btn-primary" href="#contact">Talk to Sales</a>
                <a class="btn-outline" href="#developers">View Documentation -></a>
            </div>
            <div class="cta-trust">Bank of Ghana Licensed | 30+ Networks | 24/7 Support</div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const ctaRef = ref(null);
const contentRef = ref(null);
const particleRef = ref(null);
const isActive = ref(false);
let observer;
let activeObserver;
let rafId = 0;
let latestEvent;
let motionEnabled = true;
let particlesReady = false;

const applyMove = () => {
    if (!ctaRef.value || !latestEvent) return;
    const { width, height, left, top } = ctaRef.value.getBoundingClientRect();
    const x = (latestEvent.clientX - left) / width - 0.5;
    const y = (latestEvent.clientY - top) / height - 0.5;
    ctaRef.value.style.setProperty('--cta-x', x.toFixed(2));
    ctaRef.value.style.setProperty('--cta-y', y.toFixed(2));
};

const onMove = (event) => {
    if (!motionEnabled) return;
    latestEvent = event;
    if (rafId) return;
    rafId = requestAnimationFrame(() => {
        applyMove();
        rafId = 0;
    });
};

const setupParticles = () => {
    if (!particleRef.value || particlesReady) return;
    particlesReady = true;
    for (let i = 0; i < 18; i += 1) {
        const dot = document.createElement('span');
        dot.className = 'particle-dot';
        dot.style.left = `${Math.random() * 100}%`;
        dot.style.top = `${50 + Math.random() * 50}%`;
        dot.style.animationDelay = `${Math.random() * 6}s`;
        particleRef.value.appendChild(dot);
    }
};

onMounted(() => {
    const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    const coarsePointer = window.matchMedia('(pointer: coarse)').matches;
    motionEnabled = !(prefersReduced || coarsePointer);
    activeObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                isActive.value = true;
                setupParticles();
                if (motionEnabled && ctaRef.value) {
                    ctaRef.value.addEventListener('mousemove', onMove);
                }
            } else {
                isActive.value = false;
                if (ctaRef.value) {
                    ctaRef.value.removeEventListener('mousemove', onMove);
                }
            }
        });
    }, { threshold: 0.3 });

    if (ctaRef.value) activeObserver.observe(ctaRef.value);

    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
                observer.disconnect();
            }
        });
    }, { threshold: 0.4 });

    if (contentRef.value) observer.observe(contentRef.value);
});

onBeforeUnmount(() => {
    if (ctaRef.value) {
        ctaRef.value.removeEventListener('mousemove', onMove);
    }
    if (rafId) cancelAnimationFrame(rafId);
    if (observer) observer.disconnect();
    if (activeObserver) activeObserver.disconnect();
});
</script>
