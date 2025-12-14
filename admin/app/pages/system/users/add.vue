<script setup lang="ts">
definePageMeta({
    middleware: ["auth"],
});

const router = useRouter();
const toast = useToast();
const { createUser } = useUsers();

const isSubmitting = ref(false);

const formState = reactive({
    login_id: "",
    email: "",
    name: "",
    password: "",
});

const isValid = computed(() => {
    return (
        !!formState.login_id &&
        !!formState.email &&
        !!formState.password &&
        formState.password.length >= 8
    );
});

const handleSubmit = async () => {
    if (!isValid.value) return;
    isSubmitting.value = true;

    const result = await createUser({
        login_id: formState.login_id,
        email: formState.email,
        password: formState.password,
        name: formState.name,
    });

    if (result.success) {
        toast.add({
            title: "新增成功",
            description: "已成功建立使用者",
            color: "success",
        });
        await router.push("/users");
    } else {
        toast.add({
            title: "新增失敗",
            description: result.message || "請稍後再試",
            color: "error",
        });
    }

    isSubmitting.value = false;
};

</script>
<template>
    <UDashboardPanel id="users">
        <template #header>
            <UDashboardNavbar title="新增使用者" :ui="{ right: 'gap-3' }">
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

                <UForm :state="formState" @submit="handleSubmit" class="space-y-5">
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

                    <UFormField label="密碼" name="password" required>
                        <UInput
                            v-model="formState.password"
                            type="password"
                            placeholder="至少 8 碼"
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
                            建立
                        </UButton>
                    </div>
                </UForm>
            </UCard>
        </template>
    </UDashboardPanel>
</template>