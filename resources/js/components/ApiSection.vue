<template>
    <section class="section api-section" id="apis">
       

        <div class="api-hero">
            <div class="api-pill">API-FIRST INFRASTRUCTURE</div>
            <h2>
                Power Your Platform
                <span>With Our APIs</span>
            </h2>
            <p>
                Licensed crypto infrastructure that your partners can integrate in hours, not months. Handle compliance while you
                focus on building the future of finance.
            </p>
        </div>

        <div class="api-main">
            <div class="api-list" role="tablist" aria-label="API products">
                <button
                    v-for="api in apis"
                    :key="api.key"
                    class="api-card"
                    :class="{ featured: api.featured, active: api.key === activeKey }"
                    type="button"
                    role="tab"
                    :aria-selected="api.key === activeKey"
                    @click="activeKey = api.key"
                >
                    <div class="api-card-icon" v-html="api.icon"></div>
                    <div>
                        <h3>{{ api.title }}</h3>
                        <p>{{ api.copy }}</p>
                        <div class="api-tags">
                            <span v-for="tag in api.tags" :key="tag">{{ tag }}</span>
                        </div>
                    </div>
                </button>
            </div>

            <div class="api-console">
                <div class="console-header">
                    <div class="dots">
                        <span></span><span></span><span></span>
                    </div>
                    <div class="console-title">{{ activeApi.fileName }}</div>
                    <div class="console-status">ACTIVE SESSION</div>
                </div>
                <div class="console-body">
                    <div class="console-left">
                        <div class="console-block">
                            <div class="block-title">{{ activeApi.blockTitle }}</div>
                            <div class="block-url">{{ activeApi.baseUrl }}</div>
                            <div class="endpoint-list">
                                <button
                                    v-for="endpoint in activeApi.endpoints"
                                    :key="endpoint.method + endpoint.path"
                                    class="endpoint"
                                    type="button"
                                    @click="copyEndpoint(endpoint)"
                                >
                                    <span class="method" :class="endpoint.method.toLowerCase()">{{ endpoint.method }}</span>
                                    <span class="endpoint-path">{{ endpoint.path }}</span>
                                    <span class="endpoint-copy">{{ copied === endpoint.path ? 'Copied' : 'Copy' }}</span>
                                </button>
                            </div>
                        </div>
                       <!-- <div class="code-snippet">
                            <span class="ln">01</span> const response = await fetch('/v1/deposits', {
                            <span class="ln">02</span>   method: 'POST',
                            <span class="ln">03</span>   headers: { Authorization: API_KEY },
                            <span class="ln">04</span>   body: JSON.stringify({ amount: 500, currency: 'GHS' })
                            <span class="ln">05</span> });
                        </div> -->
                    </div>
                    <div class="console-right">
                        <div class="console-side">
                            <div class="side-title">Key Features</div>
                            <ul>
                                <li v-for="feature in activeApi.features" :key="feature">{{ feature }}</li>
                            </ul>
                        </div>
                        <div class="console-side">
                            <div class="side-title">Ideal For</div>
                            <div v-for="item in activeApi.idealFor" :key="item" class="pill">{{ item }}</div>
                        </div>
                        <div class="console-actions">
                            <a class="btn-primary" href="#">View Documentation</a>
                            <a class="btn-outline" href="#">Test in Sandbox</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="api-foot">
            <div class="foot-item">PCI-DSS</div>
            <div class="foot-item">ISO-27001</div>
            <div class="foot-item">Licensed</div>
            <div class="foot-item">Global Ops</div>
        </div>
    </section>
</template>

<script setup>
import { ref, computed, watch } from 'vue';

const apis = [
    {
        key: 'fiat',
        title: 'Fiat Gateway API',
        copy: 'Convert between crypto and local currency seamlessly with high-speed settlement.',
        tags: ['Mobile Money', 'Bank Transfer', '+2 More'],
        icon: '<svg viewBox="0 0 24 24"><path d="M7 7h10"></path><path d="M14 4l3 3-3 3"></path><path d="M17 17H7"></path><path d="M10 14l-3 3 3 3"></path></svg>',
        featured: true,
        fileName: 'fiat-gateway.js',
        blockTitle: 'Fiat Gateway Endpoints',
        baseUrl: 'https://api.x-chain.io/v1/',
        endpoints: [
            { method: 'POST', path: '/v1/deposits' },
            { method: 'POST', path: '/v1/withdrawals' },
            { method: 'GET', path: '/v1/rates' }
        ],
        features: ['Mobile Money Integration', 'Bank Transfer Support', 'Real-time Processing', 'Instant Callbacks'],
        idealFor: ['Global Exchanges', 'Trading Platforms', 'Crypto Wallets']
    },
    {
        key: 'momo',
        title: 'Mobile Money API',
        copy: 'Direct integration with MTN, Vodafone, and AirtelTigo across Pan-African markets.',
        tags: ['MTN Money', 'Instant', 'AirtelTigo'],
        icon: '<svg viewBox="0 0 24 24"><rect x="7" y="3" width="10" height="18" rx="2"></rect><path d="M10 7h4"></path><path d="M10 17h4"></path></svg>',
        fileName: 'mobile-money.js',
        blockTitle: 'Mobile Money Endpoints',
        baseUrl: 'https://api.x-chain.io/v1/',
        endpoints: [
            { method: 'POST', path: '/v1/mobile-money/charge' },
            { method: 'POST', path: '/v1/mobile-money/verify' },
            { method: 'GET', path: '/v1/mobile-money/providers' }
        ],
        features: ['Carrier Network Coverage', 'Instant Authorization', 'Callback Webhooks', 'Fraud Screening'],
        idealFor: ['Fintech Apps', 'Wallet Providers', 'Payment Aggregators']
    },
    {
        key: 'cross-border',
        title: 'Cross-Border API',
        copy: 'Instant transfers between Ghana, Nigeria, Kenya and European corridors.',
        tags: ['Real-time Settlement', 'FX Optimized'],
        icon: '<svg viewBox="0 0 24 24"><circle cx="6" cy="12" r="3"></circle><circle cx="18" cy="6" r="3"></circle><circle cx="18" cy="18" r="3"></circle><path d="M8.5 11l6-4"></path><path d="M8.5 13l6 4"></path></svg>',
        fileName: 'cross-border.js',
        blockTitle: 'Cross-Border Endpoints',
        baseUrl: 'https://api.x-chain.io/v1/',
        endpoints: [
            { method: 'POST', path: '/v1/remittance/quote' },
            { method: 'POST', path: '/v1/remittance/transfer' },
            { method: 'GET', path: '/v1/remittance/status' }
        ],
        features: ['Instant Settlement', 'FX Rate Locks', 'Auto Reconciliation', 'Multi-currency Payouts'],
        idealFor: ['Remittance Providers', 'Cross-border Wallets', 'Payroll Platforms']
    },
    {
        key: 'trading',
        title: 'Trading Infrastructure',
        copy: 'Licensed deep liquidity access for partners with enterprise-grade stability.',
        tags: ['Deep Liquidity', 'Low Latency'],
        icon: '<svg viewBox="0 0 24 24"><path d="M4 12h6"></path><path d="M14 6h6"></path><path d="M14 18h6"></path><path d="M10 4v16"></path></svg>',
        fileName: 'trading-infra.js',
        blockTitle: 'Trading Infrastructure Endpoints',
        baseUrl: 'https://api.x-chain.io/v1/',
        endpoints: [
            { method: 'POST', path: '/v1/liquidity/quote' },
            { method: 'POST', path: '/v1/liquidity/execute' },
            { method: 'GET', path: '/v1/liquidity/markets' }
        ],
        features: ['Liquidity Aggregation', 'Institutional Grade Routing', 'Order Execution', 'Risk Controls'],
        idealFor: ['Exchanges', 'Brokerages', 'OTC Desks']
    }
];

const activeKey = ref(apis[0].key);
const activeApi = computed(() => apis.find((api) => api.key === activeKey.value) || apis[0]);

const copied = ref('');

const copyEndpoint = async (endpoint) => {
    const value = `${endpoint.method} ${endpoint.path}`;
    try {
        await navigator.clipboard.writeText(value);
        copied.value = endpoint.path;
        setTimeout(() => {
            if (copied.value === endpoint.path) copied.value = '';
        }, 1200);
    } catch (error) {
        copied.value = '';
    }
};

watch(activeKey, () => {
    copied.value = '';
});
</script>
