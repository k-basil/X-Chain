<template>
    <section class="section dev-section" id="developers">
        <h2 class="section-heading">Built for Builders</h2>
        <div class="dev-grid">
            <div class="code-editor" ref="editorRef">
                <div class="code-header">
                    <div class="code-title">xchain-api.ts</div>
                    <button class="copy-btn" :class="{ copied: copied }" @click="copyCode">
                        {{ copied ? 'Copied' : 'Copy' }}
                    </button>
                </div>
                <pre class="code-block" ref="codeRef"></pre>
                <div class="scanlines"></div>
            </div>
            <div class="dev-content" ref="contentRef">
                <h3>Production-Ready APIs</h3>
                <ul class="dev-features">
                    <li><span>+</span>30+ blockchain networks</li>
                    <li><span>+</span>Real-time transaction tracking</li>
                    <li><span>+</span>Comprehensive documentation</li>
                    <li><span>+</span>99.9% uptime SLA</li>
                </ul>
                <div class="dev-actions">
                    <a class="dev-cta" href="#">View API Docs -></a>
                    <a class="dev-link" href="#">Get API Key</a>
                </div>
            </div>
        </div>
    </section>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';

const code = `import { XChain } from "@xchain/sdk"\n\nconst client = new XChain({\n  apiKey: process.env.XCHAIN_API_KEY,\n  network: "ghana-mainnet"\n});\n\nconst payment = await client.payments.create({\n  amount: 2500,\n  currency: "GHS",\n  destination: "0x9c...1a2f",\n  rails: ["momo", "bank"],\n  metadata: { userId: "africa-001" }\n});\n\nconsole.log(payment.status);`;

const codeRef = ref(null);
const editorRef = ref(null);
const contentRef = ref(null);
const copied = ref(false);
let observer;
let prefersReduced = false;

const highlight = (text) => {
    const escaped = text
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;');
    return escaped
        .replace(/(\bconst\b|\bimport\b|\bfrom\b|\bawait\b|\breturn\b|\bnew\b)/g, '<span class="kw">$1</span>')
        .replace(/(\bXChain\b|\bcreate\b)/g, '<span class="fn">$1</span>')
        .replace(/("[^"]*")/g, '<span class="str">$1</span>')
        .replace(/(\b\d+\b)/g, '<span class="num">$1</span>');
};

const typeWriter = () => {
    if (!codeRef.value || codeRef.value.dataset.typed) return;
    codeRef.value.dataset.typed = 'true';
    if (prefersReduced) {
        codeRef.value.innerHTML = highlight(code);
        return;
    }
    let index = 0;
    const interval = window.setInterval(() => {
        index += 1;
        const partial = code.slice(0, index);
        if (codeRef.value) {
            codeRef.value.innerHTML = `${highlight(partial)}<span class="cursor-blink"></span>`;
        }
        if (index >= code.length) {
            window.clearInterval(interval);
            if (codeRef.value) {
                codeRef.value.innerHTML = highlight(code);
            }
        }
    }, 50);
};

const copyCode = async () => {
    try {
        await navigator.clipboard.writeText(code);
        copied.value = true;
        setTimeout(() => {
            copied.value = false;
        }, 2000);
    } catch (error) {
        copied.value = false;
    }
};

onMounted(() => {
    prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    observer = new IntersectionObserver((entries) => {
        entries.forEach((entry) => {
            if (entry.isIntersecting) {
                entry.target.classList.add('in-view');
                if (entry.target === editorRef.value) {
                    typeWriter();
                }
            }
        });
    }, { threshold: 0.3 });

    if (editorRef.value) observer.observe(editorRef.value);
    if (contentRef.value) observer.observe(contentRef.value);
});

onBeforeUnmount(() => {
    if (observer) observer.disconnect();
});
</script>
