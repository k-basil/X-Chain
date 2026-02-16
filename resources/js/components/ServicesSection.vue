<template>
    <section class="section services" id="services">
        <div class="noise"></div>
        <div class="services-intro">
            <h2 class="section-heading">Infrastructure Suite<span class="underline"></span></h2>
            <p class="section-sub">
                Empowering the African continent with enterprise-grade blockchain foundations. Robust, scalable, and built
                for the next generation of financial sovereignty.
            </p>
        </div>
        <div class="bento-grid">
            <article
                v-for="(card, index) in cards"
                :key="card.title"
                :class="['service-card', card.class, { 'map-bg': card.map }]"
                :ref="(el) => (cardRefs[index] = el)"
                :style="{ transitionDelay: card.delay + 'ms' }"
            >
                <div class="service-icon" v-html="card.icon"></div>
                <div class="service-head">
                    <h3>{{ card.title }}</h3>
                    <span v-if="card.badge" class="service-badge">{{ card.badge }}</span>
                </div>
                <p v-if="card.copy" class="service-copy">{{ card.copy }}</p>
                <ul v-if="card.bullets" class="service-bullets">
                    <li v-for="bullet in card.bullets" :key="bullet">{{ bullet }}</li>
                </ul>
                <div v-if="card.watermark" class="service-watermark" v-html="card.watermark"></div>
                <div v-if="card.cta || card.arrowOnly" class="learn-more" :class="{ 'arrow-only': card.arrowOnly }">
                    <span v-if="card.cta">{{ card.cta }}</span>
                </div>
            </article>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const cards = [
    {
        title: 'Fiat Gateway APIs',
        copy: 'Convert between crypto and local currency with mobile money and bank integration.',
        delay: 0,
        icon: '<svg viewBox="0 0 24 24"><path d="M7 7h10"></path><path d="M14 4l3 3-3 3"></path><path d="M17 17H7"></path><path d="M10 14l-3 3 3 3"></path></svg>'
    },
    {
        title: 'Mobile Money APIs',
        copy: 'Direct integration with MTN, Vodafone, and AirtelTigo payment systems.',
        badge: 'NEW',
        delay: 90,
        icon: '<svg viewBox="0 0 24 24"><rect x="7" y="3" width="10" height="18" rx="2"></rect><path d="M10 7h4"></path><path d="M10 17h4"></path></svg>'
    },
    {
        title: 'Cross-Border Payments',
        copy: 'Instant transfers between Ghana, Nigeria, and Kenya via crypto rails.',
        badge: 'NEW',
        delay: 180,
        icon: '<svg viewBox="0 0 24 24"><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="6" r="3"></circle><circle cx="18" cy="18" r="3"></circle><path d="M8.5 11l6-4"></path><path d="M8.5 13l6 4"></path></svg>'
    },
    {
        title: 'Licensed Infrastructure',
        copy: 'Fully compliant crypto infrastructure backed by regulatory approvals.',
        delay: 270,
        icon: '<svg viewBox="0 0 24 24"><path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6l8-3z"></path></svg>'
    },
    {
        title: 'Real-time Settlement',
        copy: 'Instant transaction processing and automated partner reconciliation.',
        badge: 'NEW',
        delay: 360,
        icon: '<svg viewBox="0 0 24 24"><path d="M12 2v6"></path><path d="M12 16v6"></path><path d="M4 12h6"></path><path d="M14 12h6"></path><circle cx="12" cy="12" r="3"></circle></svg>'
    },
    {
        title: 'KYC & Verification',
        copy: 'Ghana Card verification, biometric checks, and compliance screening.',
        badge: 'NEW',
        delay: 450,
        icon: '<svg viewBox="0 0 24 24"><rect x="3" y="6" width="18" height="12" rx="2"></rect><circle cx="9" cy="12" r="2.5"></circle><path d="M13 10h6"></path><path d="M13 14h6"></path></svg>'
    },
    {
        title: 'Custody Services',
        copy: 'Licensed custodial wallet infrastructure with multi-sig security.',
        badge: 'NEW',
        delay: 540,
        icon: '<svg viewBox="0 0 24 24"><rect x="5" y="10" width="14" height="10" rx="2"></rect><path d="M8 10V7a4 4 0 0 1 8 0v3"></path></svg>'
    },
    {
        title: 'Developer Tools',
        copy: 'Comprehensive SDKs, documentation, and sandbox environment.',
        delay: 630,
        icon: '<svg viewBox="0 0 24 24"><path d="M8 6l-4 6 4 6"></path><path d="M16 6l4 6-4 6"></path></svg>'
    },
    {
        title: 'Revenue Sharing',
        copy: 'Transparent partnership model with competitive revenue splits.',
        delay: 720,
        icon: '<svg viewBox="0 0 24 24"><path d="M4 12h16"></path><path d="M7 7h10"></path><path d="M7 17h10"></path></svg>'
    },
    {
        title: 'Compliance Reporting',
        copy: 'Automated Bank of Ghana and GRA reporting for all transactions.',
        badge: 'NEW',
        delay: 810,
        icon: '<svg viewBox="0 0 24 24"><path d="M7 4h10v16H7z"></path><path d="M9 8h6"></path><path d="M9 12h6"></path><path d="M9 16h4"></path></svg>'
    }
];

const cardRefs = ref([]);
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

    cardRefs.value.forEach((el) => {
        if (el) observer.observe(el);
    });
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
});
</script>
