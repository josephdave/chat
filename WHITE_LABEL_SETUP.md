# Configuración de Marca Blanca para Chatwoot

Este documento describe cómo configurar la funcionalidad de marca blanca en Chatwoot para personalizar el nombre, logo, colores y otros aspectos visuales de la plataforma.

## Variables de Entorno

Agrega las siguientes variables a tu archivo `.env` para configurar tu marca blanca:

### Configuración Básica de Marca

```bash
# Nombre de la marca que reemplazará "Chatwoot" en toda la aplicación
BRAND_NAME=TuMarca

# URL del logo personalizado (soporta URLs HTTP/HTTPS o assets locales)
BRAND_LOGO_URL=https://tu-dominio.com/tu-logo.png

# URL del favicon/icono personalizado (soporta URLs HTTP/HTTPS o assets locales)  
BRAND_FAVICON_URL=https://tu-dominio.com/tu-favicon.png

# Color primario de la marca (formato hex, ej: #1f93ff)
BRAND_PRIMARY_COLOR=#ff6b35

# Color secundario de la marca (formato hex, ej: #f0f0f0)
BRAND_SECONDARY_COLOR=#f8f9fa
```

### Configuración de Email

```bash
# Email remitente personalizado con el nombre de tu marca
MAILER_SENDER_EMAIL=TuMarca <no-reply@tu-dominio.com>
```

## Características Implementadas

### 1. Personalización del Nombre de Marca
- Reemplaza "Chatwoot" en títulos de páginas
- Personaliza mensajes de email
- Actualiza referencias en la interfaz de usuario

### 2. Logo y Favicon Personalizados
- Logo dinámico en la barra lateral
- Favicon personalizable en todas las páginas
- Soporte para imágenes locales o remotas via URL

### 3. Colores de Marca Personalizados
- Color primario aplicado al logo SVG predeterminado
- Colores de tema personalizables
- Soporte para colores primarios y secundarios

### 4. Títulos de Página Personalizados
- Título principal de la aplicación usando nombre de marca
- Títulos del Super Admin con marca personalizada
- Páginas de onboarding con nombre personalizado

### 5. Configuración de Email
- Remitente de emails personalizado
- Nombre de marca en notificaciones por email
- Templates de confirmación con marca personalizada

## Archivos Modificados

### Backend (Rails)
- `config/initializers/brand_config.rb` - Configuración central de marca blanca
- `app/controllers/dashboard_controller.rb` - Exposición de configuración al frontend
- `app/mailers/application_mailer.rb` - Email personalizado
- `app/mailers/conversation_reply_mailer.rb` - Emails de conversación personalizados
- `app/views/layouts/vueapp.html.erb` - Configuración global de la aplicación
- `app/views/super_admin/devise/sessions/new.html.erb` - Página de login del super admin
- `app/views/super_admin/application/_navigation.html.erb` - Navegación del super admin
- `app/views/installation/onboarding/index.html.erb` - Página de onboarding
- `app/views/devise/mailer/confirmation_instructions.html.erb` - Email de confirmación

### Frontend (Vue.js)
- `app/javascript/dashboard/helper/brandHelper.js` - Helper para configuración de marca
- `app/javascript/dashboard/App.vue` - Configuración global de marca
- `app/javascript/dashboard/components-next/icon/Logo.vue` - Logo dinámico
- `app/javascript/dashboard/routes/dashboard/helpcenter/components/ArticleSearch/Header.vue` - Nombre de marca en búsqueda

### Variables de Entorno
- `.env.example` - Nuevas variables de configuración

## Uso

1. **Configurar Variables**: Copia las variables del ejemplo a tu archivo `.env` y personalízalas según tu marca.

2. **Reiniciar Aplicación**: Después de modificar las variables de entorno, reinicia tu aplicación:
   ```bash
   docker-compose restart
   # o si usas servicios individuales
   docker-compose restart rails sidekiq
   ```

3. **Verificar Cambios**: 
   - El logo debería aparecer con tu imagen personalizada
   - El nombre de la marca debería reemplazar "Chatwoot" en títulos y textos
   - Los colores personalizados deberían aplicarse

## Personalización Adicional

Para personalizar otros aspectos de la aplicación:

1. **Mensajes de Email**: Modifica los templates en `app/views/mailers/`
2. **Texto de la Interfaz**: Actualiza los archivos de i18n en `config/locales/`
3. **Estilos CSS**: Personaliza los archivos de estilo para ajustar la apariencia
4. **Assets Estáticos**: Reemplaza logos e iconos en `public/brand-assets/`

## Solución de Problemas

### Logo No Aparece
- Verifica que la URL del logo sea accesible públicamente
- Asegúrate de que la variable `BRAND_LOGO_URL` esté correctamente configurada
- Revisa los logs de la aplicación por errores de carga de imágenes

### Colores No Se Aplican
- Confirma que los colores estén en formato hexadecimal válido (#RRGGBB)
- Verifica que las variables estén configuradas correctamente
- Limpia la caché del navegador

### Nombre de Marca No Aparece
- Asegúrate de que `BRAND_NAME` esté configurado
- Reinicia la aplicación después de cambiar variables de entorno
- Verifica que no haya errores en los logs de la aplicación

## Limitaciones

- Algunos textos hardcodeados pueden requerir personalización manual adicional
- Los archivos de story (Storybook) mantienen referencias a "Chatwoot" para propósitos de desarrollo
- Ciertas configuraciones empresariales pueden requerir modificaciones adicionales

## Contribuir

Si encuentras referencias hardcodeadas a "Chatwoot" que no están cubiertas por esta implementación, por favor:
1. Documenta la ubicación del texto
2. Crea una solución siguiendo los patrones establecidos
3. Actualiza este documento con los cambios realizados