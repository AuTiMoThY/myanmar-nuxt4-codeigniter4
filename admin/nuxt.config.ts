// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    compatibilityDate: "2025-07-15",
    devtools: { enabled: true },
    ssr: false, // 禁用 SSR，使用 SPA 模式（適合後台管理系統）
    modules: ["@nuxt/ui", "@nuxt/eslint", "@vueuse/nuxt", "@nuxt/image"],
    css: ["~/assets/scss/default.css"],
    runtimeConfig: {
        public: {
            apiBase:
                import.meta.env.NUXT_PUBLIC_API_BASE || "http://localhost:8080/api",
        },
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
                    // additionalData: '@use "@/assets/scss/main.scss" as *;',
                },
            },
        },
    },
});
