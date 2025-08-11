# Ocultar Funcionalidades Premium del Menú

Esta funcionalidad oculta todas las características premium y de suscripción del menú de usuario, creando una experiencia completamente limpia sin referencias a funcionalidades que requieren planes de pago.

## Funcionalidades Ocultas

### 1. Captain (AI Assistant)
**Ubicación**: Sección principal del menú
**Características eliminadas**:
- Assistants
- Documents  
- Responses
- Todas las rutas relacionadas con `/captain/*`

### 2. Custom Roles
**Ubicación**: Settings → Custom Roles
**Características eliminadas**:
- Gestión de roles personalizados
- Configuración de permisos avanzados
- Rutas `/settings/custom-roles/*`

### 3. SLA Management
**Ubicación**: Settings → SLA + Reports → SLA Reports
**Características eliminadas**:
- Configuración de SLA (Service Level Agreements)
- Reportes de SLA
- Rutas `/settings/sla/*` y reportes SLA

### 4. Billing & Payments
**Ubicación**: Settings → Billing
**Características eliminadas**:
- Gestión de facturación
- Información de planes
- Opciones de upgrade
- Rutas `/settings/billing/*`

## Archivos Modificados

### Frontend - Sidebar Menu
```
app/javascript/dashboard/components-next/sidebar/Sidebar.vue
```

**Cambios realizados**:
- Comentada sección completa de Captain
- Comentadas opciones de Custom Roles y SLA en Settings
- Comentada opción de Billing en Settings
- Comentados Reports SLA

### Frontend - Rutas Deshabilitadas
```
app/javascript/dashboard/routes/dashboard/captain/captain.routes.js
app/javascript/dashboard/routes/dashboard/settings/customRoles/customRole.routes.js
app/javascript/dashboard/routes/dashboard/settings/sla/sla.routes.js
app/javascript/dashboard/routes/dashboard/settings/billing/billing.routes.js
```

**Resultado**: Todas estas rutas devuelven arrays vacíos, efectivamente deshabilitando el acceso.

## Menú Simplificado Resultante

### Menú Principal
- ✅ Inbox
- ✅ Conversations (con todas sus sub-opciones)
- ❌ ~~Captain~~ (oculto)
- ✅ Contacts (con todas sus sub-opciones)
- ✅ Reports (sin SLA Reports)
- ✅ Campaigns
- ✅ Portals (Help Center)
- ✅ Settings (sin opciones premium)

### Settings Simplificado
- ✅ Account Settings
- ✅ Agents
- ✅ Teams
- ✅ Inboxes
- ✅ Labels
- ✅ Custom Attributes
- ✅ Automation
- ✅ Agent Bots
- ✅ Macros
- ✅ Canned Responses
- ✅ Integrations
- ✅ Audit Logs
- ❌ ~~Custom Roles~~ (oculto)
- ❌ ~~SLA~~ (oculto)
- ❌ ~~Billing~~ (oculto)

### Reports Simplificado
- ✅ Overview
- ✅ Conversation Reports
- ✅ Agent Reports
- ✅ Label Reports
- ✅ Inbox Reports
- ✅ Team Reports
- ✅ CSAT Reports
- ❌ ~~SLA Reports~~ (oculto)
- ✅ Bot Reports

## Validación de Funcionalidad

### URLs que devuelven 404 (como esperado)
```
/app/accounts/:id/captain/*
/app/accounts/:id/settings/custom-roles/*
/app/accounts/:id/settings/sla/*
/app/accounts/:id/settings/billing/*
```

### Menús completamente ocultos
- No aparecen enlaces en el sidebar
- No son accesibles mediante navegación
- No generan errores en consola

## Consideraciones Técnicas

### Feature Flags
Las rutas deshabilitadas originalmente dependían de:
- `FEATURE_FLAGS.CAPTAIN`
- `FEATURE_FLAGS.CUSTOM_ROLES`
- `FEATURE_FLAGS.SLA`
- `INSTALLATION_TYPES.CLOUD` / `INSTALLATION_TYPES.ENTERPRISE`

Ahora están completamente deshabilitadas independientemente de estos flags.

### Permisos
Las funcionalidades ocultas requerían permisos de:
- `administrator` (para la mayoría)
- `agent` (para algunas funciones de Captain)

Al estar ocultas, estos permisos no se verifican.

### Backend APIs
**Importante**: Esta implementación solo oculta la UI. Las APIs del backend para estas funcionalidades pueden seguir estando activas. Para una deshabilitación completa, también se deberían desactivar en el backend.

## Mantenimiento

### Al actualizar Chatwoot
1. **Revisar nuevas funcionalidades premium** que puedan haberse agregado
2. **Verificar que las rutas sigan deshabilitadas** después de actualizaciones
3. **Probar que el menú siga limpio** sin nuevas opciones premium

### Para habilitar funcionalidades específicas
Si en el futuro se desea habilitar alguna funcionalidad específica:

1. **Descomentar en Sidebar.vue** la sección correspondiente
2. **Restaurar las rutas** en el archivo `.routes.js` correspondiente  
3. **Verificar dependencias** y feature flags necesarios
4. **Probar funcionalidad completa** en entorno de desarrollo

### Funcionalidades que podrían agregarse en el futuro
- Advanced Analytics
- AI-powered features adicionales
- Enterprise integrations
- Advanced workflow automation
- White-label customizations adicionales

## Troubleshooting

### Problema: Aún aparecen opciones premium
**Solución**: 
- Verificar que los cambios en `Sidebar.vue` estén aplicados
- Limpiar caché del navegador
- Recompilar assets del frontend

### Problema: URLs de funcionalidades premium no devuelven 404
**Solución**:
- Verificar que los archivos `.routes.js` tengan `routes: []`
- Reiniciar servidor de desarrollo
- Verificar que no haya rutas duplicadas en otros archivos

### Problema: Errores en consola del navegador
**Solución**:
- Verificar que no haya referencias a componentes comentados
- Revisar imports de rutas deshabilitadas
- Asegurar que todas las referencias estén correctamente eliminadas

## Integración con HIDE_UPGRADE_OPTIONS

Esta funcionalidad complementa la variable `HIDE_UPGRADE_OPTIONS=true`, creando una experiencia completamente limpia:

- `HIDE_UPGRADE_OPTIONS` oculta paywalls y prompts de upgrade
- Esta funcionalidad oculta las opciones del menú premium
- Juntas crean una experiencia de marca blanca completa