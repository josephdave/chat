export const getBrandName = () => {
  return window.brandConfig?.name || window.chatwootConfig?.brandName || 'Chatwoot';
};

export const getBrandLogo = () => {
  return window.brandConfig?.logo || window.chatwootConfig?.brandLogo;
};

export const getBrandFavicon = () => {
  return window.brandConfig?.favicon || window.chatwootConfig?.brandFavicon;
};

export const getBrandPrimaryColor = () => {
  return window.brandConfig?.primaryColor || window.chatwootConfig?.brandPrimaryColor || '#1f93ff';
};

export const getBrandSecondaryColor = () => {
  return window.brandConfig?.secondaryColor || window.chatwootConfig?.brandSecondaryColor || '#f0f0f0';
};

export const replaceBrandName = (text) => {
  if (!text) return text;
  const brandName = getBrandName();
  return text.replace(/Chatwoot/g, brandName);
};