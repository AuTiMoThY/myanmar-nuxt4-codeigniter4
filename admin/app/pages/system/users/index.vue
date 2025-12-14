<script setup lang="ts">
import type { TableColumn } from "@nuxt/ui";
import { getPaginationRowModel } from "@tanstack/table-core";
import type { Row } from "@tanstack/table-core";

import type { User } from "~/types";

definePageMeta({
    middleware: ["auth"],
});

const { getUsers } = useUsers();
const toast = useToast();
const table = useTemplateRef("table");

const UButton = resolveComponent("UButton");
const UCheckbox = resolveComponent("UCheckbox");
const UDropdownMenu = resolveComponent("UDropdownMenu");

// 使用者列表資料
const users = ref<User[]>([]);
const loading = ref(false);
const selectedRows = ref<User[]>([]);

const rowSelection = ref();

function getRowItems(row: Row<User>) {
    return [
        {
            type: "label",
            label: "Actions",
        },
        {
            label: "Copy customer ID",
            icon: "i-lucide-copy",
            onSelect() {
                navigator.clipboard.writeText(row.original.id.toString());
                toast.add({
                    title: "Copied to clipboard",
                    description: "Customer ID copied to clipboard",
                });
            },
        },
        {
            type: "separator",
        },
        {
            label: "View customer details",
            icon: "i-lucide-list",
        },
        {
            label: "View customer payments",
            icon: "i-lucide-wallet",
        },
        {
            type: "separator",
        },
        {
            label: "Delete customer",
            icon: "i-lucide-trash",
            color: "error",
            onSelect() {
                toast.add({
                    title: "Customer deleted",
                    description: "The customer has been deleted.",
                });
            },
        },
    ];
}
// 表格欄位定義
const columns: TableColumn<User>[] = [
    {
        id: "select",
        header: ({ table }) =>
            h(UCheckbox, {
                modelValue: table.getIsSomePageRowsSelected()
                    ? "indeterminate"
                    : table.getIsAllPageRowsSelected(),
                "onUpdate:modelValue": (value: boolean | "indeterminate") =>
                    table.toggleAllPageRowsSelected(!!value),
                ariaLabel: "Select all",
            }),
        cell: ({ row }) =>
            h(UCheckbox, {
                modelValue: row.getIsSelected(),
                "onUpdate:modelValue": (value: boolean | "indeterminate") =>
                    row.toggleSelected(!!value),
                ariaLabel: "Select row",
            }),
    },
    {
        accessorKey: "id",
        header: "no",
    },
    {
        accessorKey: "login_id",
        header: "帳號",
    },
    {
        accessorKey: "name",
        header: "姓名",
    },
    {
        accessorKey: "status",
        header: "狀態",
    },
    {
        accessorKey: "last_login_at",
        header: "最後登入",
    },
    {
        accessorKey: "created_at",
        header: "建立時間",
    },
    {
        id: "actions",
        cell: ({ row }) => {
            return h(
                "div",
                { class: "text-right" },
                h(
                    UDropdownMenu,
                    {
                        content: {
                            align: "end",
                        },
                        items: getRowItems(row),
                    },
                    () =>
                        h(UButton, {
                            icon: "i-lucide-ellipsis-vertical",
                            color: "neutral",
                            variant: "ghost",
                            class: "ml-auto",
                        })
                )
            );
        },
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

const pagination = ref({
    pageIndex: 0,
    pageSize: 10,
});

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
                    <NuxtLink to="/users/add">
                        <UButton color="primary" variant="soft">
                            <UIcon name="i-lucide-plus" />
                            <span>新增使用者</span>
                        </UButton>
                    </NuxtLink>
                </template>
            </UDashboardNavbar>

            <UDashboardToolbar>
                <template #left>
                    <UInput
                        :model-value="(table?.tableApi?.getColumn('login_id')?.getFilterValue() as string)"
                        class="max-w-sm"
                        icon="i-lucide-search"
                        placeholder="搜尋帳號..."
                        @update:model-value="
                            table?.tableApi
                                ?.getColumn('login_id')
                                ?.setFilterValue($event)
                        "
                    />
                    <!--
                        <div class="text-sm text-gray-500 dark:text-gray-400">
                            共 {{ users.length }} 位使用者
                        </div>
                        -->
                </template>
            </UDashboardToolbar>
        </template>

        <template #body>
            <div class="flex items-center justify-between gap-3 mt-auto">
                <div class="flex">
                    <usersDeleteModal
                        :count="
                            table?.tableApi?.getFilteredSelectedRowModel().rows
                                .length
                        "
                    >
                        <UButton
                            v-if="
                                table?.tableApi?.getFilteredSelectedRowModel()
                                    .rows.length
                            "
                            label="Delete"
                            color="error"
                            variant="subtle"
                            icon="i-lucide-trash"
                        >
                            <template #trailing>
                                <UKbd>
                                    {{
                                        table?.tableApi?.getFilteredSelectedRowModel()
                                            .rows.length
                                    }}
                                </UKbd>
                            </template>
                        </UButton>
                    </usersDeleteModal>
                </div>

                <div class="flex items-center gap-1.5">
                    <div class="text-sm text-muted">
                        {{
                            table?.tableApi?.getFilteredSelectedRowModel().rows
                                .length || 0
                        }}
                        /
                        {{
                            table?.tableApi?.getFilteredRowModel().rows
                                .length || 0
                        }}
                        位使用者
                    </div>
                    <UPagination
                        :default-page="
                            (table?.tableApi?.getState().pagination.pageIndex ||
                                0) + 1
                        "
                        :items-per-page="
                            table?.tableApi?.getState().pagination.pageSize
                        "
                        :total="
                            table?.tableApi?.getFilteredRowModel().rows.length
                        "
                        @update:page="(p: number) => table?.tableApi?.setPageIndex(p - 1)"
                    />
                </div>
            </div>
            <UTable
                ref="table"
                v-model:row-selection="rowSelection"
                v-model:pagination="pagination"
                :pagination-options="{
                    getPaginationRowModel: getPaginationRowModel(),
                }"
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

            <div
                class="flex items-center justify-between gap-3 border-t border-default pt-4 mt-auto"
            >
                <div class="text-sm text-muted">
                    {{
                        table?.tableApi?.getFilteredSelectedRowModel().rows
                            .length || 0
                    }}
                    /
                    {{
                        table?.tableApi?.getFilteredRowModel().rows.length || 0
                    }}
                    位使用者
                </div>

                <div class="flex items-center gap-1.5">
                    <UPagination
                        :default-page="
                            (table?.tableApi?.getState().pagination.pageIndex ||
                                0) + 1
                        "
                        :items-per-page="
                            table?.tableApi?.getState().pagination.pageSize
                        "
                        :total="
                            table?.tableApi?.getFilteredRowModel().rows.length
                        "
                        @update:page="(p: number) => table?.tableApi?.setPageIndex(p - 1)"
                    />
                </div>
            </div>
        </template>
    </UDashboardPanel>
</template>
