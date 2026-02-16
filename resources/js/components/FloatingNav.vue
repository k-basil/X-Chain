<template>
    <nav class="floating-nav" :class="{ visible: isVisible, hidden: isHidden }">
        <div class="nav-logo">
            <img :src="navLogo" alt="X-Chain" />
        </div>
        <div class="nav-links">
            <a v-for="link in links" :key="link.href" :href="link.href" :class="{ active: activeSection === link.id }">
                {{ link.label }}
            </a>
        </div>
        <a class="nav-cta" href="#cta">Get Started</a>
    </nav>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import navLogo from '../assets/xchain-loader.png';

const links = [
    { id: 'services', label: 'Products', href: '#services' },
    { id: 'apis', label: 'APIs', href: '#apis' },
    { id: 'stats', label: 'Patnership', href: '#stats' },
    { id: 'faq', label: 'FAQ', href: '#faq' },
    { id: 'contact', label: 'Contact', href: '#contact' },
];

const isVisible = ref(false);
const isHidden = ref(false);
const activeSection = ref('');
let lastScroll = 0;

const updateNav = () => {
    const hero = document.getElementById('hero');
    const heroBottom = hero ? hero.offsetHeight - 80 : 0;
    const currentScroll = window.scrollY;

    if (currentScroll > heroBottom) {
        isVisible.value = true;
    } else {
        isVisible.value = false;
    }

    if (currentScroll > lastScroll) {
        isHidden.value = false;
    } else {
        isHidden.value = true;
    }

    lastScroll = currentScroll;
};

const updateActive = () => {
    const offset = window.innerHeight * 0.4;
    links.forEach((link) => {
        const section = document.getElementById(link.id);
        if (!section) return;
        const rect = section.getBoundingClientRect();
        if (rect.top <= offset && rect.bottom >= offset) {
            activeSection.value = link.id;
        }
    });
};

const onScroll = () => {
    updateNav();
    updateActive();
};

onMounted(() => {
    updateNav();
    updateActive();
    window.addEventListener('scroll', onScroll, { passive: true });
    window.addEventListener('resize', onScroll);
});

onBeforeUnmount(() => {
    window.removeEventListener('scroll', onScroll);
    window.removeEventListener('resize', onScroll);
});
</script>
