<template>
    <section class="section support-section" id="support">
        <div class="support-gridlines"></div>
        <div class="support-header">
            <h2>What we support</h2>
            <p class="support-sub">Mainnets and testnets</p>
        </div>
        <div class="support-tabs">
            <button
                v-for="tab in tabs"
                :key="tab"
                class="support-tab"
                :class="{ active: tab === activeTab }"
                type="button"
                @click="activeTab = tab"
            >
                {{ tab }}
            </button>
        </div>
        <div class="support-carousel" aria-label="Supported networks">
            <div class="support-marquee">
                <div class="support-track" role="list">
                    <div
                        v-for="card in visibleCards"
                        :key="card.code + '-' + activeTab"
                        class="support-card"
                        role="listitem"
                    >
                        <div class="support-card-code">{{ card.code }}</div>
                        <div class="support-card-name">{{ card.name }}</div>
                    </div>
                </div>
                <div class="support-track" aria-hidden="true">
                    <div v-for="card in visibleCards" :key="card.code + '-' + activeTab + '-dup'" class="support-card">
                        <div class="support-card-code">{{ card.code }}</div>
                        <div class="support-card-name">{{ card.name }}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="support-divider"></div>

        <div class="faq-section" id="faq">
            <div class="faq-left">
                <h3>FAQ</h3>
                <div class="faq-cats">
                    <button
                        v-for="cat in categories"
                        :key="cat"
                        class="faq-cat"
                        :class="{ active: cat === activeCategory }"
                        type="button"
                        @click="activeCategory = cat"
                    >
                        <span class="dot"></span>
                        {{ cat }}
                    </button>
                </div>
            </div>
            <div class="faq-right">
                <div
                    v-for="(item, index) in filteredFaqs"
                    :key="item.q"
                    class="faq-item"
                    :class="{ open: openIndex === index }"
                >
                    <button class="faq-q" type="button" @click="toggleFaq(index)">
                        <span>{{ item.q }}</span>
                        <span class="chev"></span>
                    </button>
                    <div class="faq-a">
                        {{ item.a }}
                    </div>
                </div>
            </div>
        </div>

        <div class="support-divider"></div>

        <div class="contact-section" id="contact">
            <h3>Get in Touch</h3>
            <div class="contact-grid">
                <div class="contact-info">
                    <div class="info-card">
                        <div class="info-icon">
                            <span>@</span>
                        </div>
                        <div>
                            <div class="info-title">Email Support</div>
                            <div class="info-text">Reach out to our core engineering team for technical queries.</div>
                            <a class="info-link" href="mailto:support@xchain.io">support@xchain.io</a>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-icon">
                            <span>¦</span>
                        </div>
                        <div>
                            <div class="info-title">Office Location</div>
                            <div class="info-text">Infrastructure Hub, Tech Park<br />Accra, Ghana</div>
                        </div>
                    </div>
                    <div class="info-card">
                        <div class="info-icon">
                            <span>?</span>
                        </div>
                        <div>
                            <div class="info-title">Follow Us</div>
                            <div class="social-row">
                                <a href="#" aria-label="Twitter">T</a>
                                <a href="#" aria-label="GitHub">G</a>
                                <a href="#" aria-label="LinkedIn">in</a>
                            </div>
                        </div>
                    </div>
                </div>
                <form class="contact-form">
                    <label>
                        Full Name
                        <input type="text" placeholder="John Doe" />
                    </label>
                    <label>
                        Work Email
                        <input type="email" placeholder="john@company.com" />
                    </label>
                    <label>
                        Message
                        <textarea rows="4" placeholder="How can we help you scale?"></textarea>
                    </label>
                    <button type="button" class="btn-primary full">Send Message</button>
                </form>
            </div>
        </div>

        <div class="support-footer">
            <div class="footer-links">
                <a href="#">Documentation</a>
                <a href="#">Twitter</a>
                <a href="#">GitHub</a>
                <a href="#">Discord</a>
            </div>
            <div class="footer-copy">© 2024 X-Chain Infrastructure. All rights reserved.</div>
        </div>
    </section>
</template>

<script setup>
import { ref, computed, watch } from 'vue';

const tabs = ['Blockchains', 'Exchanges', 'Tokens', 'Layers & Standards'];
const activeTab = ref('Blockchains');

const supportCards = {
    Blockchains: [
        { code: 'DASH', name: 'Dash' },
        { code: 'LTC', name: 'Litecoin' },
        { code: 'DOGE', name: 'Dogecoin' },
        { code: 'ZIL', name: 'Zilliqa' },
        { code: 'ZEC', name: 'Zcash' },
        { code: 'BSC', name: 'BNB Smart\nChain' },
        { code: 'MATIC', name: 'Polygon' }
    ],
    Exchanges: [
        { code: 'BN', name: 'Binance' },
        { code: 'CB', name: 'Coinbase' },
        { code: 'KR', name: 'Kraken' },
        { code: 'OKX', name: 'OKX' },
        { code: 'HT', name: 'Huobi' },
        { code: 'BY', name: 'Bybit' },
        { code: 'KU', name: 'KuCoin' }
    ],
    Tokens: [
        { code: 'USDT', name: 'Tether' },
        { code: 'USDC', name: 'USD Coin' },
        { code: 'DAI', name: 'Dai' },
        { code: 'LINK', name: 'Chainlink' },
        { code: 'UNI', name: 'Uniswap' },
        { code: 'AAVE', name: 'Aave' },
        { code: 'MKR', name: 'Maker' }
    ],
    'Layers & Standards': [
        { code: 'L2', name: 'Layer 2' },
        { code: 'EVM', name: 'EVM Compatible' },
        { code: 'IBC', name: 'IBC' },
        { code: 'ZK', name: 'ZK Proofs' },
        { code: 'MPC', name: 'MPC Custody' },
        { code: 'AML', name: 'AML/KYC' },
        { code: 'API', name: 'Open APIs' }
    ]
};

const visibleCards = computed(() => supportCards[activeTab.value] || []);

const categories = ['General', 'Wallets', 'Assets & Tokens', 'Security'];
const activeCategory = ref('General');

const faqs = [
    {
        category: 'General',
        q: 'What is X-Chain Infrastructure?',
        a: 'X-Chain provides high-performance node infrastructure for developers and enterprises, supporting 50+ mainnets and testnets with 99.9% uptime and low latency.'
    },
    {
        category: 'General',
        q: 'How do I integrate X-Chain APIs?',
        a: 'Use our unified API with SDKs and WebSocket support to deploy and monitor apps across multiple chains in minutes.'
    },
    {
        category: 'Wallets',
        q: 'Are testnets supported for development?',
        a: 'Yes. We provide dedicated testnet endpoints, faucets, and tooling for rapid development workflows.'
    },
    {
        category: 'Wallets',
        q: 'Do you support custodial and non-custodial wallets?',
        a: 'Yes. We support both custodial and non-custodial integrations with MPC and multi-sig options.'
    },
    {
        category: 'Security',
        q: 'What security measures are in place?',
        a: 'We run hardened node infrastructure with continuous monitoring, DDoS protection, and audited security controls.'
    },
    {
        category: 'Security',
        q: 'How do you protect API access?',
        a: 'We use scoped API keys, IP allowlists, rate limiting, and real-time anomaly detection.'
    },
    {
        category: 'Assets & Tokens',
        q: 'Which tokens are supported?',
        a: 'We support major stablecoins and DeFi assets with compliance-ready reporting and custody options.'
    },
    {
        category: 'Assets & Tokens',
        q: 'Can you add new tokens on request?',
        a: 'Yes. We can onboard new assets after security, liquidity, and compliance reviews.'
    }
];

const openIndex = ref(0);

const toggleFaq = (index) => {
    openIndex.value = openIndex.value === index ? -1 : index;
};

const filteredFaqs = computed(() => faqs.filter((item) => item.category === activeCategory.value));

watch(activeCategory, () => {
    openIndex.value = 0;
});
</script>
