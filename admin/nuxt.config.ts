// https://nuxt.com/docs/api/configuration/nuxt-config

// 判斷是否為生產環境（generate/build）
const processEnv = (
    globalThis as { process?: { env?: Record<string, string | undefined> } }
).process?.env;
const isProduction = processEnv?.NODE_ENV === "production";

// 設定 API Base URL
// 優先使用環境變數 NUXT_PUBLIC_API_BASE
// 如果沒有設定，開發環境使用 localhost，生產環境使用正式網址
// 注意：執行 generate 時，Nuxt 會自動設定 NODE_ENV=production
const apiBase =
    processEnv?.NUXT_PUBLIC_API_BASE ||
    (isProduction ? "" : "http://localhost:8080");

console.log("========== apiBase ==========", apiBase);

export default defineNuxtConfig({
    compatibilityDate: "2025-07-15",
    devtools: { enabled: true },
    ssr: false, // 禁用 SSR，使用 SPA 模式（適合後台管理系統）
    modules: ["@nuxt/ui", "@nuxt/eslint", "@vueuse/nuxt", "@nuxt/image"],
    // 設定基礎路徑：開發時為 /，生產環境為 /admin/
    app: {
        baseURL: isProduction ? "/admin/" : "/",
    },

    css: ["~/assets/css/default.css"],
    // 前後端分離：透過環境變數或預設的 API Base URL 呼叫後端
    runtimeConfig: {
        public: {
            apiBase
        }
    },
    // 開發時將 /api 代理到後端（避免拿到 Nuxt 的 HTML）
    nitro: {
        devProxy: {
            "/api": {
                target: apiBase,
                changeOrigin: true
            }
        },
        // 靜態生成時預渲染圖片路徑（當 ssr: false 時需要）
        prerender: {
            routes: isProduction ? [
                "/_ipx/q_80/images/logo.svg"
            ] : []
        }
    },

    eslint: {
        config: {
            stylistic: {
                commaDangle: "never",
                braceStyle: "1tbs",
                quotes: "double"
            }
        }
    },
    // routeRules: {
    //     "/api/**": {
    //         proxy: {
    //             to: "http://localhost:8080/api/**", // Replace with your backend API URL
    //         },
    //     },
    // },
    vite: {
        css: {
            preprocessorOptions: {
                scss: {
                    // additionalData: '@use "~/assets/scss/main.scss" as *;',
                },
            },
        },
    },
});
