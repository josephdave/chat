# Ocultar Opciones de Upgrade y Premium

Esta funcionalidad permite ocultar todas las opciones de upgrade, billing, y características premium de Chatwoot para crear una experiencia de marca blanca completa sin referencias a planes de pago.

## Configuración

### Variable de Entorno

Agrega la siguiente variable a tu archivo `.env`:

```bash
# Ocultar prompts de upgrade, billing, y características premium (true/false)
HIDE_UPGRADE_OPTIONS=true
```

### Valores Posibles

- `true`: Oculta todas las opciones de upgrade y premium (predeterminado)
- `false`: Muestra las opciones de upgrade normalmente

## Características Ocultadas

### Frontend (Vue.js)
- **Página de Upgrade**: Nunca se muestra la página que bloquea el uso por límites excedidos
- **Componentes Paywall**: Todos los modal de paywall están completamente ocultos
- **Billing en Sidebar**: La opción "Billing" está comentada en el menú de configuraciones
- **Rutas de Billing**: Las rutas de billing están deshabilitadas

### Backend (Rails)
- **Super Admin**: Oculta avisos de cambios premium no autorizados
- **Planes Enterprise**: Oculta información de planes actuales y enlaces de gestión
- **Alertas de Límites**: Oculta avisos sobre exceso de agentes

## Archivos Modificados

### Frontend
```
app/javascript/dashboard/routes/dashboard/upgrade/UpgradePage.vue
app/javascript/dashboard/routes/dashboard/settings/components/BasePaywallModal.vue
app/javascript/dashboard/routes/dashboard/settings/customRoles/component/CustomRolePaywall.vue
app/javascript/dashboard/routes/dashboard/settings/sla/components/SLAPaywallEnterprise.vue
app/javascript/dashboard/components-next/sidebar/Sidebar.vue
app/javascript/dashboard/routes/dashboard/settings/billing/billing.routes.js
```

### Backend
```
config/initializers/brand_config.rb
app/controllers/dashboard_controller.rb
app/views/super_admin/settings/show.html.erb
```

### Configuración
```
.env.example
```

## Funcionalidades Afectadas

### Completamente Ocultas
1. **Páginas de Upgrade**: No se muestran páginas de bloqueo por límites
2. **Modales de Paywall**: No aparecen ventanas emergentes de upgrade
3. **Menú de Billing**: Opción eliminada del sidebar
4. **Rutas de Facturación**: URLs de billing devuelven 404
5. **Alertas Premium**: No se muestran avisos de características premium

### Super Admin (Parcialmente Ocultas)
1. **Avisos de Cambios Premium**: Alertas sobre modificaciones no autorizadas
2. **Información de Planes**: Detalles del plan actual y enlaces de gestión
3. **Alertas de Límites de Agentes**: Avisos sobre exceso de usuarios

## Implementación Técnica

### 1. Configuración Centralizada
```ruby
# config/initializers/brand_config.rb
def self.hide_upgrade_options?
  ENV.fetch('HIDE_UPGRADE_OPTIONS', 'true').downcase == 'true'
end
```

### 2. Exposición al Frontend
```ruby
# app/controllers/dashboard_controller.rb
def brand_config
  {
    # ... otras configuraciones ...
    HIDE_UPGRADE_OPTIONS: BrandConfig.hide_upgrade_options?
  }
end
```

### 3. Componentes Vue Ocultos
```vue
<template>
  <!-- White-label mode: hide paywall components -->
  <div style="display: none;" />
</template>
```

### 4. Lógica Condicional en Vistas
```erb
<% unless BrandConfig.hide_upgrade_options? %>
  <!-- Contenido premium -->
<% end %>
```

## Casos de Uso

### Instalaciones On-Premise
Ideal para organizaciones que despliegan Chatwoot en sus propios servidores y no quieren mostrar referencias a planes de pago o límites de funcionalidades.

### Soluciones de Marca Blanca
Perfecto para proveedores de servicios que ofrecen Chatwoot como parte de su suite de productos sin referencias a los planes comerciales originales.

### Entornos Corporativos
Útil en entornos empresariales donde se prefiere una experiencia limpia sin distracciones comerciales.

## Limitaciones

### Lo que NO se Oculta
- Funcionalidades que requieren características enterprise pueden seguir mostrando limitaciones a nivel de código
- Algunos textos en archivos de i18n pueden contener referencias a funcionalidades premium
- APIs que verifican límites de uso pueden seguir funcionando normalmente

### Consideraciones de Desarrollo
- Al actualizar Chatwoot, revisar si se han agregado nuevas referencias a funcionalidades premium
- Los tests pueden fallar si dependen de componentes ocultos
- Algunas funcionalidades pueden no estar completamente habilitadas solo por ocultar la UI

## Mantenimiento

### Al Actualizar Chatwoot
1. Revisar nuevos archivos que contengan referencias a "upgrade", "paywall", "premium", "enterprise"
2. Aplicar la lógica de ocultación a nuevos componentes
3. Probar que todas las funcionalidades principales sigan funcionando

### Para Nuevas Características Premium
1. Identificar nuevos componentes de paywall
2. Agregar lógica condicional basada en `HIDE_UPGRADE_OPTIONS`
3. Verificar que la experiencia de usuario sea consistente

## Troubleshooting

### Problema: Aún se ven opciones de upgrade
**Solución**: 
1. Verificar que `HIDE_UPGRADE_OPTIONS=true` esté en el `.env`
2. Reiniciar la aplicación Rails
3. Limpiar caché del navegador

### Problema: Funcionalidades premium no funcionan
**Nota**: Esta configuración solo oculta la UI. Las limitaciones del backend pueden seguir aplicando. Para habilitar funcionalidades completas, revisar la configuración de enterprise features en el código.

### Problema: Errores en rutas de billing
**Esperado**: Las rutas de billing están deshabilitadas intencionalmente y devolverán 404.