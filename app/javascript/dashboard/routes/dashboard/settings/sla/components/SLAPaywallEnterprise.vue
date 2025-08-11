<script setup>
import BaseEmptyState from './BaseEmptyState.vue';
import BasePaywallModal from 'dashboard/routes/dashboard/settings/components/BasePaywallModal.vue';

const props = defineProps({
  isSuperAdmin: {
    type: Boolean,
    default: false,
  },
  isOnChatwootCloud: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits(['upgrade']);
const i18nKey = props.isOnChatwootCloud ? 'PAYWALL' : 'ENTERPRISE_PAYWALL';
</script>

<template>
  <!-- White-label mode: hide SLA paywall -->
  <div style="display: none;" />
</template>
