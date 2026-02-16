<template>
    <section class="trust-bar" aria-label="Trust bar">
        <div class="marquee" ref="marqueeRef">
            <div class="marquee-track">
                <div v-for="item in items" :key="item.id" class="marquee-item" :class="{ badge: item.badge }">
                    <span v-if="item.icon" class="icon" v-html="item.icon"></span>
                    <span v-else class="partner-logo">{{ item.label }}</span>
                    <span v-if="item.icon">{{ item.label }}</span>
                </div>
            </div>
            <div class="marquee-track" aria-hidden="true">
                <div v-for="item in items" :key="item.id + '-dup'" class="marquee-item" :class="{ badge: item.badge }">
                    <span v-if="item.icon" class="icon" v-html="item.icon"></span>
                    <span v-else class="partner-logo">{{ item.label }}</span>
                    <span v-if="item.icon">{{ item.label }}</span>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const items = [
    {
        id: 'sandbox',
        label: 'Bank of Ghana Regulatory Sandbox',
        badge: true,
        icon: '<svg viewBox="0 0 24 24"><path d="M12 3l8 3v6c0 5-3.5 8-8 9-4.5-1-8-4-8-9V6l8-3z"></path></svg>'
    },
    {
        id: 'blockchains',
        label: '30+ Blockchains Supported',
        icon: '<svg viewBox="0 0 24 24"><path d="M8 12a4 4 0 0 1 4-4h3"></path><path d="M16 12a4 4 0 0 1-4 4H9"></path><path d="M7 7l-3 3 3 3"></path><path d="M17 17l3-3-3-3"></path></svg>'
    },
    {
        id: 'countries',
        label: '3 Countries Connected (GH - NG - KE)',
        icon: '<svg viewBox="0 0 24 24"><path d="M12 2a7 7 0 0 0-7 7c0 5 7 13 7 13s7-8 7-13a7 7 0 0 0-7-7z"></path><circle cx="12" cy="9" r="2.5"></circle></svg>'
    },
    {
        id: 'licensed',
        label: 'Licensed and Compliant',
        icon: '<svg viewBox="0 0 24 24"><path d="M5 13l4 4L19 7"></path></svg>'
    },
    { id: 'ng', label: 'NGRAVE' },
    { id: 'cw', label: 'CoolWallet' },
    { id: 'gm', label: 'GAIMIN' }
];

const marqueeRef = ref(null);
let intervalId = 0;

const updateGlow = () => {
    if (!marqueeRef.value) return;
    const itemsEls = marqueeRef.value.querySelectorAll('.marquee-item');
    const center = window.innerWidth / 2;
    itemsEls.forEach((el) => {
        const rect = el.getBoundingClientRect();
        const itemCenter = rect.left + rect.width / 2;
        if (Math.abs(itemCenter - center) < 120) {
            el.classList.add('center');
        } else {
            el.classList.remove('center');
        }
    });
};

onMounted(() => {
    updateGlow();
    intervalId = window.setInterval(updateGlow, 300);
});

onBeforeUnmount(() => {
    window.clearInterval(intervalId);
});
</script>
