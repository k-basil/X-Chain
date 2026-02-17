<template>
    <section class="section how-it-works" id="how">
        <h2 class="section-heading">Why Partner with XCHAIN?</h2>
        <div class="flow">
            <div
                :class="['flow-stage', { hub: stages[0].hub }]"
                :ref="(el) => (stageRefs[0] = el)"
                :style="{ transitionDelay: stages[0].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[0].icon"></div>
                <div class="stage-title">{{ stages[0].title }}</div>
                <div class="stage-desc">{{ stages[0].copy }}</div>
            </div>
            <div class="flow-arrow"></div>
            <div
                :class="['flow-stage', { hub: stages[1].hub }]"
                :ref="(el) => (stageRefs[1] = el)"
                :style="{ transitionDelay: stages[1].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[1].icon"></div>
                <div class="stage-title">{{ stages[1].title }}</div>
                <div class="stage-desc">{{ stages[1].copy }}</div>
            </div>
            <div class="flow-arrow branch"></div>
            <div
                :class="['flow-stage', { hub: stages[2].hub }]"
                :ref="(el) => (stageRefs[2] = el)"
                :style="{ transitionDelay: stages[2].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[2].icon"></div>
                <div class="stage-title">{{ stages[2].title }}</div>
                <div class="stage-desc">{{ stages[2].copy }}</div>
            </div>
            <div class="flow-arrow branch"></div>
            <div
                :class="['flow-stage', { hub: stages[3].hub }]"
                :ref="(el) => (stageRefs[3] = el)"
                :style="{ transitionDelay: stages[3].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[3].icon"></div>
                <div class="stage-title">{{ stages[3].title }}</div>
                <div class="stage-desc">{{ stages[3].copy }}</div>
            </div>
            <div class="flow-arrow branch"></div>
            <div
                :class="['flow-stage', { hub: stages[4].hub }]"
                :ref="(el) => (stageRefs[4] = el)"
                :style="{ transitionDelay: stages[4].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[4].icon"></div>
                <div class="stage-title">{{ stages[4].title }}</div>
                <div class="stage-desc">{{ stages[4].copy }}</div>
            </div>
            <div class="flow-arrow"></div>
            <div
                :class="['flow-stage', { hub: stages[5].hub }]"
                :ref="(el) => (stageRefs[5] = el)"
                :style="{ transitionDelay: stages[5].delay + 'ms' }"
            >
                <div class="stage-icon" v-html="stages[5].icon"></div>
                <div class="stage-title">{{ stages[5].title }}</div>
                <div class="stage-desc">{{ stages[5].copy }}</div>
            </div>
            <div class="flow-counter">
                Average Transaction Time: <span ref="counterRef">0</span>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const stages = [
    {
        title: 'Licensed & Compliant',
        copy: 'We handle all regulatory requirements so you don\'t have to',
        delay: 0,
        hub: false,
        icon: '<svg viewBox="0 0 24 24"><rect x="7" y="3" width="10" height="18" rx="2"></rect><circle cx="12" cy="17" r="1"></circle></svg>'
    },
    {
        title: 'Fast Integration',
        copy: 'Get live in hours with our RESTful APIs and webhooks',
        delay: 50,
        hub: true,
        icon: '<svg viewBox="0 0 24 24"><path d="M12 2l8 5v10l-8 5-8-5V7l8-5z"></path><circle cx="12" cy="12" r="2"></circle></svg>'
    },
    {
        title: 'Revenue Share',
        copy: 'Earn from every transaction your users make through our platform',
        delay: 100,
        hub: false,
        icon: '<svg viewBox="0 0 24 24"><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="8" r="3"></circle><circle cx="18" cy="16" r="3"></circle><path d="M8.5 11l6-2.5"></path><path d="M8.5 13l6 2.5"></path></svg>'
    },
    {
        title: 'Keep Your UX',
        copy: 'Your users never leave your platform - we\'re invisible infrastructure',
        delay: 150,
        hub: false,
        icon: '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"></circle><path d="M3 12h18"></path><path d="M12 3c3 3 3 15 0 18"></path><path d="M12 3c-3 3-3 15 0 18"></path></svg>'
    },
    {
        title: 'Regional Coverage',
        copy: 'Expand across Ghana with our growing network',
        delay: 200,
        hub: false,
        icon: '<svg viewBox="0 0 24 24"><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="8" r="3"></circle><circle cx="18" cy="16" r="3"></circle><path d="M8.5 11l6-2.5"></path><path d="M8.5 13l6 2.5"></path></svg>'
    },
    {
        title: '27/7 Support',
        copy: 'Dedicated technical support and account management',
        delay: 250,
        hub: false,
        icon: '<svg viewBox="0 0 24 24"><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="8" r="3"></circle><circle cx="18" cy="16" r="3"></circle><path d="M8.5 11l6-2.5"></path><path d="M8.5 13l6 2.5"></path></svg>'
    }
];

const stageRefs = ref([]);
const counterRef = ref(null);
let observer;
let prefersReduced = false;

const animateCounter = () => {
    if (!counterRef.value) return;
    if (prefersReduced) {
        counterRef.value.textContent = '<2 seconds';
        return;
    }
    const target = 2;
    const duration = 1500;
    const start = performance.now();

    const tick = (now) => {
        const progress = Math.min((now - start) / duration, 1);
        const value = Math.max(1, Math.floor(progress * target));
        counterRef.value.textContent = `<${value} seconds`;
        if (progress < 1) {
            requestAnimationFrame(tick);
        } else {
            counterRef.value.textContent = '<2 seconds';
        }
    };

    requestAnimationFrame(tick);
};

onMounted(() => {
    prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
                observer.unobserve(entry.target);
            }
        });
    }, { threshold: 0.2 });

    stageRefs.value.forEach((el) => {
        if (el) observer.observe(el);
    });

    const counterObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                animateCounter();
                counterObserver.disconnect();
            }
        });
    }, { threshold: 0.6 });

    if (counterRef.value) {
        counterObserver.observe(counterRef.value);
    }
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
});
</script>
