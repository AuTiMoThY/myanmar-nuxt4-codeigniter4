<script setup lang="ts">
definePageMeta({
    middleware: ['auth']
})

const { user } = useAuth();

console.log(localStorage.getItem('auth_token'));
console.log(localStorage.getItem('user'));

</script>

<template>
    <UDashboardPanel id="home">
        <template #header>
            <UDashboardNavbar title="Home" :ui="{ right: 'gap-3' }">
                <template #leading>
                <UDashboardSidebarCollapse />

                </template>

                <template #right>

                </template>
            </UDashboardNavbar>

            <UDashboardToolbar>
                <template #left>

                </template>
            </UDashboardToolbar>
        </template>

        <template #body>
            <div class="p-6">
                <h2 class="text-2xl font-bold mb-4">歡迎回來，{{ user?.full_name || user?.username }}！</h2>
                <p class="text-gray-600 dark:text-gray-400">這是您的後台管理介面首頁。</p>
            </div>
        </template>
    </UDashboardPanel>
</template>
