<template>
    <div class="xchain-app">
        <LoaderOverlay />
        <ScrollProgress />
        <CustomCursor />
        <FloatingNav />

        <main>
            <HeroSection />
            <TrustBar />
            <ServicesSection />
            <HowItWorksSection />
            <ApiSection />
            <EcosystemsSection />
            <DeveloperSection />
            <StatsSection />
            <PartnersSection />
            <ComplianceSection />
            <SupportContactSection />
        </main>
    </div>
</template>

<script setup>
import LoaderOverlay from './components/LoaderOverlay.vue';
import ScrollProgress from './components/ScrollProgress.vue';
import CustomCursor from './components/CustomCursor.vue';
import FloatingNav from './components/FloatingNav.vue';
import HeroSection from './components/HeroSection.vue';
import TrustBar from './components/TrustBar.vue';
import ServicesSection from './components/ServicesSection.vue';
import HowItWorksSection from './components/HowItWorksSection.vue';
import ApiSection from './components/ApiSection.vue';
import EcosystemsSection from './components/EcosystemsSection.vue';
import DeveloperSection from './components/DeveloperSection.vue';
import StatsSection from './components/StatsSection.vue';
import PartnersSection from './components/PartnersSection.vue';
import ComplianceSection from './components/ComplianceSection.vue';
import SupportContactSection from './components/SupportContactSection.vue';
</script>
