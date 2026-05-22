---
name: looker-extension
description: >-
  Comprehensive guide for building, securing, and deploying Looker Extensions
  using React and Vite. Covers frontend configurations, entitlements, API usage,
  and best practices.
---

# Looker Extension Expert Guide

This skill provides a comprehensive guide for developers building applications on the **Looker Extension Framework**. It advocates for a modern stack while acknowledging the framework's flexibility.

## 🧩 Framework Agnosticism

The Looker Extension Framework is **framework-agnostic**. Because extensions run inside a sandboxed `<iframe>`, you can use *any* technology that runs in a browser:
*   **React** (Highly recommended for rich UIs and best SDK support)
*   **Vue.js**
*   **Angular**
*   **Svelte**
*   **Vanilla JavaScript**

The core communication with Looker happens via postMessage protocols handled by the Looker Extension SDK.

## 🎯 Core Architecture: Full-Frame vs Tile Extensions

Extensions can be deployed in two main contexts:

| Type | Purpose | SDK Context |
| :--- | :--- | :--- |
| **Full-Frame** | Standalone App in Looker UI Navigation | `extensionSDK` |
| **Tile Extension** | Embedded inside an existing Dashboard | `extensionSDK.tileContext` |

## 🚀 The Opinionated Stack: React + Vite

While you can use any framework, this guide strongly advocates for **React + Vite** for building full-featured applications.

### Why React?
*   **First-Class SDK**: `@looker/extension-sdk-react` provides seamless connection wrappers (`ExtensionProvider`) and hooks (`useExtensionContext`).
*   **Looker UI Theme**: `@looker/components` is built on React, allowing your extension to mirror the exact look and feel of standard Looker dashboards/applications.

### Why Vite?
*   **Speed**: Instant server start and lightning-fast Hot Module Replacement (HMR).
*   **Modern**: Better support for ES modules and modern JavaScript features.
*   **Simplicity**: Cleaner configuration compared to Webpack.

## 🛠️ Step-by-Step Implementation (React + Vite)

### 1. Initialize Project
```bash
npm create vite@latest my-looker-extension -- --template react-ts
cd my-looker-extension
npm install
```

### 2. Install Looker SDKs
```bash
npm install @looker/extension-sdk @looker/extension-sdk-react @looker/sdk
npm install @looker/components styled-components # For native UI
```

### 3. Basic Application Structure (`src/App.tsx`)
```typescript
import React from 'react'
import { ExtensionProvider, useExtensionContext } from '@looker/extension-sdk-react'

const InnerApp = () => {
  const { coreSDK } = useExtensionContext()
  const [user, setUser] = React.useState<any>(null)

  React.useEffect(() => {
    coreSDK.ok(coreSDK.me()).then(setUser).catch(console.error)
  }, [coreSDK])

  return (
    <div style={{ padding: '20px' }}>
      <h1>Hello from Looker Extension!</h1>
      {user && <p>Welcome, {user.display_name}</p>}
    </div>
  )
}

export const App = () => (
  <ExtensionProvider>
    <InnerApp />
  </ExtensionProvider>
)
export default App
```

## 📞 Calling the API

### Via React Hooks (Recommended)
Use `useExtensionContext` to access `coreSDK`.
```typescript
const { coreSDK } = useExtensionContext()
// Call API methods directly
coreSDK.ok(coreSDK.all_lookml_models()).then(models => ...)
```

### Via Core SDK (Vanilla JS)
If not using React, use `LookerExtensionSDK.create()`.
```javascript
import { LookerExtensionSDK } from '@looker/extension-sdk'

async function initialize() {
  const extensionSDK = await LookerExtensionSDK.create()
  const coreSDK = extensionSDK.coreSDK
  const me = await coreSDK.ok(coreSDK.me())
}
```

## 🏗️ Architectural Patterns

### 1. Backend-less Pattern
Use this pattern to avoid maintaining a custom backend for simple operations.
*   **Mechanic**: Use Looker's SQL Runner APIs (`create_sql_query`, `run_sql_query`) to read/write directly to BigQuery scratch schemas.
*   **Benefit**: Zero server maintenance, fully contained within Looker security model.

### 2. Backend-Connected Pattern
Use this pattern when you need a custom backend for complex logic.
*   **Mechanic**: Rely on **Looker User Attributes** to securely pass connection parameters (URL, API Key) to the frontend.
*   **Benefit**: Avoids storing secrets in `localStorage`.

## 🔐 Manifest Configuration & Entitlements (`manifest.lkml`)

Your extension's capabilities are strictly controlled by the `manifest.lkml` file.

### Example Manifest
```lookml
application: my_extension {
  label: "My Custom Extension"
  url: "http://localhost:5173/bundle.js"
  
  mount_points: {
    standalone: yes
    dashboard_extension: yes
  }

  entitlements: {
    use_form_submit: yes
    navigation: yes
    new_window: yes
    use_clipboard: yes
    core_api_methods: ["me", "all_lookml_models", "run_inline_query"]
    external_api_urls: ["https://api.example.com"]
    global_user_attributes: ["backend_url"]
  }
}
```

## ⚠️ Gotchas & Pitfalls

### Storage Sandbox
Do **not** use `window.localStorage` or `sessionStorage`. They fail or clear unpredictably in iframes.
*   **Fix**: Use `extensionSDK.localStorage` or persistent `scoped_user_attributes`.

### React Version Conflicts
React 18+ root mounting can conflict with older Looker container wrappers.
*   **Action**: Stick to React 17 unless explicitly testing backwards compatibility, or use standard `createRoot` with `looker-components` version locks. (Note: Recent apps like `chat-extension` use React 19, so verify compatibility if upgrading).

### Entitlement Locks
If a feature fails with "Missing capability", check `manifest.lkml`.
*   **Action**: You must explicitly declare entitlements in the Looker project manifest.

### 🚨 Sandboxed Iframe & Bundling Gotchas

#### 1. DOM Mounting Race Conditions (React Error #299)
* **Problem**: Looker loads the compiled `bundle.js` script and executes it synchronously before the browser has finished parsing and appending the `<div id="root"></div>` mounting container to the DOM, returning `null` and crashing React with `createRoot(): Target container is not a DOM element.`
* **Solution**: Implement a robust DOM ready-state checker inside `main.tsx` / `index.tsx`. If the DOM is already interactive, mount React immediately; otherwise, defer mounting by listening to the `DOMContentLoaded` event. 
* **Self-Healing Container Fallback**: To be completely host-agnostic, write a fallback that dynamically creates a `div` element with `id="root"`, appends it directly to `document.body` at runtime, and mounts React onto it if it is missing from the host markup.

#### 2. Browser Silent ESM Script Blockage (Uncaught SyntaxError)
* **Problem**: Looker's iframe sandbox script injector appends standard `<script>` tags *without* `type="module"` support. If Vite compiles `bundle.js` using default ES module (ESM) syntax (containing `import` or `export`), the browser rejects it, crashing execution silently with no visible errors on screen.
* **Solution**: Force Rollup inside `vite.config.ts` to bundle the production output into a self-executing **IIFE (Immediately Invoked Function Expression)** format (`format: 'iife'`, `name: 'MyDashboard'`). This compiles all module syntax away, ensuring 100% loading compatibility inside standard script tags.

#### 3. Recharts Flex Container Zero-Width Collapse
* **Problem**: Recharts `<ResponsiveContainer>` requires its parent element to have a strictly defined width to compute layouts. When nested inside CSS Flexbox grids inside sandboxed iframes, the browser collapses the parent container's width to exactly `0px`, rendering the charts completely invisible even if the underlying API queries run successfully (200 OK).
* **Solution**: Force an explicit style **`width="100%"`** (or `style={{ width: '100%' }}`) on the direct parent Box wrapping the Recharts `<ResponsiveContainer>` element.

#### 4. Iframe Viewport Height Clipping & Scroll Lockages
* **Problem**: Looker iframe host sandboxes disable scrolling (`overflow: hidden`) and lock height to the viewport, completely clipping off-screen metrics and charts below the fold.
* **Solution**: Lock the React app's root wrapper height and activate vertical scrolling *inside* the iframe container itself:
  ```css
  height: 100vh;
  overflow-y: auto;
  overflow-x: hidden;
  box-sizing: border-box;
  ```

#### 5. Looker Component Card Auto-Stretched Space Inflation
* **Problem**: Direct child `Card` components (like filters panels) stretch to fill the entire vertical `100vh` height of the scrollable container, creating a massive blank white gap at the top of the screen.
* **Cause**: The main wrapper extends a library `<Box>` component which acts as a CSS Flex container with stretch layout properties enabled.
* **Solution**: Redefine the main layout container as a standard HTML **`div`** (`styled.div`) instead of a library Box to enforce normal block-level flow. Also, explicitly inject **`height: auto !important;`** inside custom styled Card definitions to break default library Card stretching rules.

#### 6. Looker API Query Parameters Schema (`view` vs `explore`)
* **Problem**: TypeScript compilation fails when using `explore: 'my_explore'` inside the SDK's `run_inline_query` payload.
* **Fact**: In Looker's `IWriteQuery` API model payload, the explore name must strictly be mapped to the key **`view`** (e.g. `view: 'transactions'`), not `explore`. Reverting to `view` satisfies the TypeScript compiler.

## 📁 Additional Resources & Scripts

This skill folder contains additional resources to assist you:

*   **References**:
    *   [SQL Runner Persistence Pattern](./references/patterns/sql-runner-persistence.md): Detailed guide on reading/writing to BigQuery directly from the frontend.
    *   [Local Development Guide](./references/local-development.md): Recommendations for standing up the extension in local development.
    *   [Backend Requirements Reference](./references/backend-requirements.md): Details on connection parameters, CORS, and auth.
*   **Scripts**:
    *   [Scaffold Extension Script](./scripts/scaffold-extension.sh): A bash script to quickly initialize a Vite + React project pre-configured for Looker.
