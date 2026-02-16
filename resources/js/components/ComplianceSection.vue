<template>
    <section class="section compliance" id="compliance" ref="sectionRef" :class="{ 'is-active': isActive }">
        <div class="kente"></div>
        <h2 class="section-heading">Built on Trust, Rooted in Compliance</h2>
        <div class="compliance-grid">
            <div class="seal reveal" ref="sealRef">
                <div class="seal-circle">BoG</div>
                <h3>Approved Regulatory Sandbox Participant</h3>
                <p style="margin-top: 10px; color: var(--gray-light);">
                    Licensed fintech entity under Bank of Ghana supervision.
                </p>
            </div>
            <div class="timeline" ref="timelineRef">
                <div class="timeline-line"></div>
                <div v-for="milestone in milestones" :key="milestone.year" class="timeline-item">
                    <div class="timeline-dot"></div>
                    <div class="timeline-content"><strong>{{ milestone.year }}</strong> - {{ milestone.text }}</div>
                </div>
            </div>
        </div>
        <div class="compliance-icons">
            <div class="compliance-icon" v-for="icon in icons" :key="icon.label">
                <span v-html="icon.svg"></span>
                {{ icon.label }}
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const milestones = [
    { year: '2022', text: 'Founded and Incorporated' },
    { year: '2023', text: 'Regulatory Sandbox Approved' },
    { year: '2024', text: 'Full Licensing Obtained' },
    { year: '2025', text: 'Regional Expansion' }
];

const icons = [
    {
        label: 'Ghana Card',
        svg: '<svg viewBox="0 0 24 24"><rect x="4" y="5" width="16" height="14" rx="2"></rect><path d="M7 9h10"></path></svg>'
    },
    {
        label: 'KYC Verified',
        svg: '<svg viewBox="0 0 24 24"><path d="M5 13l4 4L19 7"></path></svg>'
    },
    {
        label: 'GRA Reporting',
        svg: '<svg viewBox="0 0 24 24"><path d="M7 4h10v16H7z"></path><path d="M9 8h6"></path></svg>'
    },
    {
        label: 'Bank of Ghana',
        svg: '<svg viewBox="0 0 24 24"><path d="M3 10h18v8H3z"></path><path d="M7 10V7h10v3"></path></svg>'
    }
];

const timelineRef = ref(null);
const sealRef = ref(null);
const sectionRef = ref(null);
const isActive = ref(false);
let observer;
let activeObserver;

onMounted(() => {
    activeObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            isActive.value = entry.isIntersecting;
        });
    }, { threshold: 0.2 });

    if (sectionRef.value) activeObserver.observe(sectionRef.value);

    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
            }
        });
    }, { threshold: 0.3 });

    if (timelineRef.value) observer.observe(timelineRef.value);
    if (sealRef.value) observer.observe(sealRef.value);
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
    if (activeObserver) activeObserver.disconnect();
});
</script>
