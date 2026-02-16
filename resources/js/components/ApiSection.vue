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
            <div class="api-list">
                <div class="api-card featured">
                    <div class="api-card-icon">?</div>
                    <div>
                        <h3>Fiat Gateway API</h3>
                        <p>Convert between crypto and local currency seamlessly with high-speed settlement.</p>
                        <div class="api-tags">
                            <span>Mobile Money</span>
                            <span>Bank Transfer</span>
                            <span>+2 More</span>
                        </div>
                    </div>
                </div>
                <div class="api-card">
                    <div class="api-card-icon">?</div>
                    <div>
                        <h3>Mobile Money API</h3>
                        <p>Direct integration with MTN, Vodafone, and AirtelTigo across Pan-African markets.</p>
                        <div class="api-tags">
                            <span>MTN Money</span>
                            <span>Instant</span>
                        </div>
                    </div>
                </div>
                <div class="api-card">
                    <div class="api-card-icon">?</div>
                    <div>
                        <h3>Cross-Border API</h3>
                        <p>Instant transfers between Ghana, Nigeria, Kenya and European corridors.</p>
                        <div class="api-tags">
                            <span>Real-time Settlement</span>
                        </div>
                    </div>
                </div>
                <div class="api-card">
                    <div class="api-card-icon">?</div>
                    <div>
                        <h3>Trading Infrastructure</h3>
                        <p>Licensed deep liquidity access for partners with enterprise-grade stability.</p>
                        <div class="api-tags">
                            <span>Deep Liquidity</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="api-console">
                <div class="console-header">
                    <div class="dots">
                        <span></span><span></span><span></span>
                    </div>
                    <div class="console-title">api-v1-documentation.js</div>
                    <div class="console-status">ACTIVE SESSION</div>
                </div>
                <div class="console-body">
                    <div class="console-left">
                        <div class="console-block">
                            <div class="block-title">Fiat Gateway Endpoints</div>
                            <div class="block-url">https://api.x-chain.io/v1/</div>
                            <div class="endpoint-list">
                                <button
                                    v-for="endpoint in endpoints"
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
                                <li>Mobile Money Integration</li>
                                <li>Bank Transfer Support</li>
                                <li>Real-time Processing</li>
                                <li>Instant Callbacks</li>
                            </ul>
                        </div>
                        <div class="console-side">
                            <div class="side-title">Ideal For</div>
                            <div class="pill">Global Exchanges</div>
                            <div class="pill">Trading Platforms</div>
                            <div class="pill">Crypto Wallets</div>
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
import { ref } from 'vue';

const endpoints = [
    { method: 'POST', path: '/v1/deposits' },
    { method: 'POST', path: '/v1/withdrawals' },
    { method: 'GET', path: '/v1/rates' }
];

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
</script>
