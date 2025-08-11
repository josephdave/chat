<script setup>
import Icon from 'next/icon/Icon.vue';
import ButtonV4 from 'next/button/Button.vue';

defineProps({
  featurePrefix: {
    type: String,
    required: true,
  },
  i18nKey: {
    type: String,
    required: true,
  },
  isOnChatwootCloud: {
    type: Boolean,
    default: false,
  },
  isSuperAdmin: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits(['upgrade']);
</script>

<template>
  <!-- White-label mode: hide paywall components -->
  <div style="display: none;" />
</template>
