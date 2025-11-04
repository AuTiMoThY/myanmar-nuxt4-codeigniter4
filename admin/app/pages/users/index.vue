<script setup lang="ts">
import type { TableColumn } from "@nuxt/ui";

definePageMeta({
    middleware: ["auth"],
});

const { getUsers } = useUsers();
const toast = useToast();

// 使用者列表資料
const users = ref<any[]>([]);
const loading = ref(false);
const selectedRows = ref<any[]>([]);

// 表格欄位定義
const columns: TableColumn<any>[] = [
    {
        accessorKey: "id",
        header: "ID",
    },
    {
        accessorKey: "username",
        header: "Username",
    },
    {
        accessorKey: "email",
        header: "Email",
    },
    {
        accessorKey: "full_name",
        header: "Full Name",
    },
    {
        accessorKey: "status",
        header: "Status",
    },
    {
        accessorKey: "last_login",
        header: "Last Login",
    },
    {
        accessorKey: "created_at",
        header: "Created At",
    },
];

// 載入使用者資料
const loadUsers = async () => {
    loading.value = true;
    try {
        const result = await getUsers();
        if (result.success) {
            users.value = result.data;
        } else {
            toast.add({
                title: "錯誤",
                description: result.message || "載入使用者列表失敗",
                color: "error",
            });
        }
    } catch (error) {
        console.error("載入使用者列表錯誤:", error);
        toast.add({
            title: "錯誤",
            description: "載入使用者列表時發生錯誤",
            color: "error",
        });
    } finally {
        loading.value = false;
    }
};

// 頁面載入時取得資料
onMounted(() => {
    loadUsers();
});

// 角色徽章顏色
const getRoleBadgeColor = (role: string) => {
    const colors: Record<string, string> = {
        admin: "red",
        manager: "blue",
        user: "gray",
    };
    return colors[role] || "gray";
};

// 狀態徽章顏色
const getStatusBadgeColor = (status: string) => {
    const colors: Record<string, string> = {
        active: "green",
        inactive: "gray",
        suspended: "red",
    };
    return colors[status] || "gray";
};

// 格式化日期
const formatDate = (dateString: string) => {
    if (!dateString) return "-";
    const date = new Date(dateString);
    return date.toLocaleString("zh-TW", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
    });
};
</script>

<template>
    <UDashboardPanel id="users">
        <template #header>
            <UDashboardNavbar title="帳號設定" :ui="{ right: 'gap-3' }">
                <template #leading>
                    <UDashboardSidebarCollapse />
                </template>

                <template #right>
                    <NuxtLink to="/users/create">
                        <UButton color="primary" variant="outline">
                            <UIcon name="i-lucide-plus" />
                            <span>Add User</span>
                        </UButton>
                    </NuxtLink>
                </template>
            </UDashboardNavbar>

            <UDashboardToolbar>
                <template #left>
                    <div class="text-sm text-gray-500 dark:text-gray-400">
                        共 {{ users.length }} 位使用者
                    </div>
                </template>
            </UDashboardToolbar>
        </template>

        <template #body>
            <UTable
                ref="table"
                class="shrink-0"
                :data="users"
                :columns="columns"
                :loading="loading"
                :ui="{
                    base: 'table-fixed border-separate border-spacing-0',
                    thead: '[&>tr]:bg-elevated/50 [&>tr]:after:content-none',
                    tbody: '[&>tr]:last:[&>td]:border-b-0',
                    th: 'py-2 first:rounded-l-lg last:rounded-r-lg border-y border-default first:border-l last:border-r',
                    td: 'border-b border-default',
                    separator: 'h-0',
                }"
            />
        </template>
    </UDashboardPanel>
</template>
