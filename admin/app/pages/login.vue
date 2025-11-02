<script setup lang="ts">
definePageMeta({
    layout: false,
    middleware: [],
});

const router = useRouter();
const { login, register } = useAuth();
const toast = useToast();

// 登入表單
const formState = reactive({
    username: "",
    password: "",
    remember: false,
});

const isLoading = ref(false);
const error = ref("");

const handleLogin = async () => {
    isLoading.value = true;
    error.value = "";

    const result = await login(formState.username, formState.password);

    if (result.success) {
        toast.add({
            title: "登入成功",
            description: "歡迎回來！",
            color: "green",
        });
        await router.push("/");
    } else {
        error.value = result.message;
    }

    isLoading.value = false;
};

// 註冊表單
const showRegisterModal = ref(false);
const registerState = reactive({
    username: "",
    email: "",
    full_name: "",
    password: "",
    password_confirm: "",
});

const isRegistering = ref(false);
const registerError = ref("");

const isRegisterFormValid = computed(() => {
    return (
        registerState.username &&
        registerState.email &&
        registerState.password &&
        registerState.password.length >= 8 &&
        registerState.password === registerState.password_confirm
    );
});

const handleRegister = async () => {
    if (!isRegisterFormValid.value) {
        registerError.value = "請確認所有欄位都已正確填寫";
        return;
    }

    isRegistering.value = true;
    registerError.value = "";

    const result = await register({
        username: registerState.username,
        email: registerState.email,
        full_name: registerState.full_name,
        password: registerState.password,
    });

    if (result.success) {
        toast.add({
            title: "註冊成功",
            description: "您已成功註冊並登入！",
            color: "green",
        });
        showRegisterModal.value = false;
        await router.push("/");
    } else {
        registerError.value = result.message;
    }

    isRegistering.value = false;
};
</script>

<template>
    <div
        class="min-h-screen flex items-center justify-center bg-gray-50 dark:bg-gray-900 py-12 px-4 sm:px-6 lg:px-8"
    >
        <div class="max-w-md w-full space-y-8">
            <div>
                <div class="flex justify-center">
                    <img
                        class="h-16 w-auto"
                        src="/images/logo.png"
                        alt="Logo"
                    />
                </div>
                <h2
                    class="mt-6 text-center text-3xl font-extrabold text-gray-900 dark:text-white"
                >
                    登入您的帳號
                </h2>
            </div>

            <UCard>
                <template #header>
                    <h3 class="text-lg font-semibold">歡迎回來</h3>
                </template>

                <UForm
                    :state="formState"
                    @submit="handleLogin"
                    class="space-y-6"
                >
                    <UFormField
                        label="使用者名稱或電子郵件"
                        name="username"
                        required
                    >
                        <UInput
                            v-model="formState.username"
                            type="text"
                            placeholder="請輸入使用者名稱或電子郵件"
                            icon="i-heroicons-user"
                            size="lg"
                            :disabled="isLoading"
                            class="w-full"
                        />
                    </UFormField>

                    <UFormField label="密碼" name="password" required>
                        <UInput
                            v-model="formState.password"
                            type="password"
                            placeholder="請輸入密碼"
                            icon="i-heroicons-lock-closed"
                            size="lg"
                            :disabled="isLoading"
                            class="w-full"
                        />
                    </UFormField>

                    <div class="flex items-center justify-between">
                        <UCheckbox
                            v-model="formState.remember"
                            label="記住我"
                        />
                        <UButton
                            variant="link"
                            color="primary"
                            size="sm"
                            :padded="false"
                        >
                            忘記密碼？
                        </UButton>
                    </div>

                    <UButton
                        type="submit"
                        block
                        size="lg"
                        :loading="isLoading"
                        :disabled="!formState.username || !formState.password"
                    >
                        登入
                    </UButton>

                    <div v-if="error" class="mt-4">
                        <UAlert
                            icon="i-heroicons-exclamation-triangle"
                            color="red"
                            variant="soft"
                            :title="error"
                        />
                    </div>
                </UForm>
            </UCard>

            <div class="text-center">
                <p class="text-sm text-gray-600 dark:text-gray-400">
                    還沒有帳號？

                    <!-- 註冊模態框 -->
                    <UModal :ui="{ content: 'sm:max-w-md' }">
                        <UButton
                            variant="link"
                            color="primary"
                            size="sm"
                            :padded="false"
                        >
                            立即註冊
                        </UButton>

                        <template #content>
                            <UCard>
                                <template #header>
                                    <h3 class="text-lg font-semibold">
                                        註冊新帳號
                                    </h3>
                                </template>

                                <UForm
                                    :state="registerState"
                                    @submit="handleRegister"
                                    class="space-y-4"
                                >
                                    <UFormField
                                        label="使用者名稱"
                                        name="username"
                                        required
                                    >
                                        <UInput
                                            v-model="registerState.username"
                                            type="text"
                                            placeholder="請輸入使用者名稱"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField
                                        label="電子郵件"
                                        name="email"
                                        required
                                    >
                                        <UInput
                                            v-model="registerState.email"
                                            type="email"
                                            placeholder="請輸入電子郵件"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField label="全名" name="full_name">
                                        <UInput
                                            v-model="registerState.full_name"
                                            type="text"
                                            placeholder="請輸入全名（選填）"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField
                                        label="密碼"
                                        name="password"
                                        required
                                    >
                                        <UInput
                                            v-model="registerState.password"
                                            type="password"
                                            placeholder="請輸入密碼（至少8個字元）"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField
                                        label="確認密碼"
                                        name="password_confirm"
                                        required
                                    >
                                        <UInput
                                            v-model="
                                                registerState.password_confirm
                                            "
                                            type="password"
                                            placeholder="請再次輸入密碼"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <div v-if="registerError" class="mt-4">
                                        <UAlert
                                            icon="i-heroicons-exclamation-triangle"
                                            color="red"
                                            variant="soft"
                                            :title="registerError"
                                        />
                                    </div>

                                    <div class="flex gap-3">
                                        <UButton
                                            type="button"
                                            variant="outline"
                                            block
                                            @click="showRegisterModal = false"
                                            :disabled="isRegistering"
                                        >
                                            取消
                                        </UButton>
                                        <UButton
                                            type="submit"
                                            block
                                            :loading="isRegistering"
                                            :disabled="!isRegisterFormValid"
                                        >
                                            註冊
                                        </UButton>
                                    </div>
                                </UForm>
                            </UCard>
                        </template>
                    </UModal>
                </p>
            </div>
        </div>
    </div>
</template>
