<script setup lang="ts">
definePageMeta({
    middleware: ["auth"],
});

const router = useRouter();
const route = useRoute();
const toast = useToast();
const { getUser, updateUser } = useUsers();

const isLoading = ref(true);
const isSubmitting = ref(false);
const userId = computed(() => route.params.id as string);

const formState = reactive({
    login_id: "",
    email: "",
    name: "",
    status: "active" as "active" | "inactive" | "suspended",
    password: "", // 可選：變更密碼
});

const isValid = computed(() => {
    return !!formState.login_id && !!formState.email;
});

const loadData = async () => {
    isLoading.value = true;
    const result = await getUser(userId.value);
    if (result.success) {
        const data = result.data || {};
        formState.login_id = data.login_id || "";
        formState.email = data.email || "";
        // 兼容 name/full_name
        formState.name = data.name || data.full_name || "";
        formState.status = (data.status as any) || "active";
    } else {
        toast.add({
            title: "讀取失敗",
            description: result.message || "無法讀取使用者資料",
            color: "error",
        });
        router.back();
    }
    isLoading.value = false;
};

onMounted(loadData);

const handleSubmit = async () => {
    if (!isValid.value) return;
    isSubmitting.value = true;

    const payload: any = {
        login_id: formState.login_id,
        email: formState.email,
        name: formState.name,
        status: formState.status,
    };
    if (formState.password && formState.password.length >= 8) {
        payload.password = formState.password;
    }

    const result = await updateUser(userId.value, payload);
    if (result.success) {
        toast.add({
            title: "更新成功",
            description: "使用者資料已更新",
            color: "success",
        });
        router.push("/users");
    } else {
        toast.add({
            title: "更新失敗",
            description: result.message || "請稍後再試",
            color: "error",
        });
    }

    isSubmitting.value = false;
};
</script>

<template>
    <UDashboardPanel id="users-edit">
        <template #header>
            <UDashboardNavbar title="編輯使用者" :ui="{ right: 'gap-3' }">
                <template #leading>
                    <UDashboardSidebarCollapse />
                </template>

                <template #right>
                    <UButton variant="outline" color="neutral" @click="router.back()">
                        返回
                    </UButton>
                </template>
            </UDashboardNavbar>
        </template>

        <template #body>
            <UCard>
                <template #header>
                    <h3 class="text-base font-semibold">基本資料</h3>
                </template>

                <div v-if="isLoading">
                    <ULoadingIcon />
                </div>
                <UForm
                    v-else
                    :state="formState"
                    @submit="handleSubmit"
                    class="space-y-5"
                >
                    <UFormField label="帳號" name="login_id" required>
                        <UInput
                            v-model="formState.login_id"
                            placeholder="請輸入帳號"
                            :disabled="isSubmitting"
                        />
                    </UFormField>

                    <UFormField label="電子信箱" name="email" required>
                        <UInput
                            v-model="formState.email"
                            type="email"
                            placeholder="請輸入電子信箱"
                            :disabled="isSubmitting"
                        />
                    </UFormField>

                    <UFormField label="姓名" name="name">
                        <UInput
                            v-model="formState.name"
                            placeholder="請輸入姓名（可選）"
                            :disabled="isSubmitting"
                        />
                    </UFormField>

                    <UFormField label="狀態" name="status">
                        <USelect
                            v-model="formState.status"
                            :options="[
                                { label: '啟用', value: 'active' },
                                { label: '停用', value: 'inactive' },
                                { label: '停權', value: 'suspended' },
                            ]"
                            :disabled="isSubmitting"
                        />
                    </UFormField>

                    <UFormField label="變更密碼" name="password" :description="'至少 8 碼，留空則不變更'">
                        <UInput
                            v-model="formState.password"
                            type="password"
                            placeholder="若需變更請輸入新密碼"
                            :disabled="isSubmitting"
                        />
                    </UFormField>

                    <div class="flex gap-3 pt-2">
                        <UButton
                            type="button"
                            variant="outline"
                            color="neutral"
                            @click="router.back()"
                            :disabled="isSubmitting"
                        >
                            取消
                        </UButton>
                        <UButton
                            type="submit"
                            color="primary"
                            :loading="isSubmitting"
                            :disabled="!isValid"
                        >
                            儲存
                        </UButton>
                    </div>
                </UForm>
            </UCard>
        </template>
    </UDashboardPanel>
</template>

