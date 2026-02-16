<template>
    <section class="section stats" id="stats">
        <div class="stats-grid" ref="statsRef">
            <div v-for="(stat, index) in stats" :key="stat.label" class="stat-card">
                <div class="stat-number" :ref="(el) => (statRefs[index] = el)">0</div>
                <div class="stat-label">{{ stat.label }}</div>
            </div>
        </div>
        <div class="stat-footnote">Trusted infrastructure for Africa's digital future</div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const stats = [
    { value: 30, suffix: '+', label: 'Blockchains Supported' },
    { value: 3, suffix: '', label: 'Countries Connected' },
    { value: 100, suffix: '%', label: 'Licensed and Compliant' }
];

const statsRef = ref(null);
const statRefs = ref([]);
let observer;
let prefersReduced = false;

const createParticles = (container) => {
    for (let i = 0; i < 10; i += 1) {
        const particle = document.createElement('span');
        particle.className = 'particle';
        particle.style.setProperty('--x', `${(Math.random() - 0.5) * 120}px`);
        particle.style.setProperty('--y', `${(Math.random() - 0.5) * 120}px`);
        particle.style.left = '50%';
        particle.style.top = '40%';
        container.appendChild(particle);
        setTimeout(() => particle.remove(), 1000);
    }
};

const animateStat = (el, target, suffix) => {
    if (prefersReduced) {
        el.textContent = `${target}${suffix}`;
        return;
    }
    const duration = 1500;
    const start = performance.now();

    const tick = (now) => {
        const progress = Math.min((now - start) / duration, 1);
        const value = Math.floor(progress * target);
        el.textContent = `${value}${suffix}`;
        if (progress < 1) {
            requestAnimationFrame(tick);
        } else {
            el.textContent = `${target}${suffix}`;
            createParticles(el.parentElement);
        }
    };

    requestAnimationFrame(tick);
};

onMounted(() => {
    prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                statRefs.value.forEach((el, index) => {
                    if (el && !el.dataset.animated) {
                        el.dataset.animated = 'true';
                        animateStat(el, stats[index].value, stats[index].suffix);
                    }
                });
                observer.disconnect();
            }
        });
    }, { threshold: 0.4 });

    if (statsRef.value) {
        observer.observe(statsRef.value);
    }
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
});
</script>
