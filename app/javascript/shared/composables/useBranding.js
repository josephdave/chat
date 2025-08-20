/**
 * Composable for branding-related utilities
 * Provides methods to customize text with installation-specific branding
 */
import { useMapGetter } from 'dashboard/composables/store.js';

export function useBranding() {
  const globalConfig = useMapGetter('globalConfig/get');
  /**
   * Replaces "Chatwoot" in text with the brand name from global config
   * @param {string} text - The text to process
   * @returns {string} - Text with "Chatwoot" replaced by brand name
   */
  const replaceInstallationName = text => {
    if (!text) return text;

    const brandName = globalConfig.value?.brandName;
    if (!brandName) return text;

    return text.replace(/Chatwoot/g, brandName);
  };

  return {
    replaceInstallationName,
  };
}
