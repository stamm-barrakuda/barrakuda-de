CMS.registerMediaLibrary({
  name: 'disabled',
  jinit: () => ({ show: () => undefined, enableStandalone: () => false }),
});
