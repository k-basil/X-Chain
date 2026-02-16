<template>
    <section class="section partners" id="partners">
        <h2 class="section-heading">Trusted by Industry Leaders</h2>
        <div class="partners-grid">
            <div
                v-for="(partner, index) in partners"
                :key="partner"
                class="partner-card"
                :ref="(el) => (partnerRefs[index] = el)"
                :style="{ transitionDelay: `${index * 0.1}s` }"
            >
                <span>{{ partner }}</span>
            </div>
        </div>
        <div class="partners-note">And growing...</div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const partners = ['NGRAVE', 'CoolWallet', 'GAIMIN', 'Bank of Ghana', 'Partner X', 'Partner Y'];
const partnerRefs = ref([]);
let observer;

onMounted(() => {
    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.2 });

    partnerRefs.value.forEach((el) => {
        if (el) observer.observe(el);
    });
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
});
</script>
