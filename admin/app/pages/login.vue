<script setup lang="ts">
definePageMeta({
    layout: false,
    middleware: [],
});

const router = useRouter();
const { login } = useAuth();
const toast = useToast();

// 登入表單
const isShowPassword = ref(false);
const formState = reactive({
    login_id: "",
    password: "",
    remember: false,
});

const isLoading = ref(false);
const error = ref("");

// 載入已儲存的帳號資訊
onMounted(() => {
    if (import.meta.client) {
        const savedLogin_id = localStorage.getItem("remembered_login_id");
        const savedPassword = localStorage.getItem("remembered_password");
        
        if (savedLogin_id && savedPassword) {
            formState.login_id = savedLogin_id;
            formState.password = savedPassword;
            formState.remember = true;
        }
    }
});

const handleLogin = async () => {
    isLoading.value = true;
    error.value = "";

    const result = await login(formState.login_id, formState.password);

    if (result.success) {
        // 處理記住我功能
        if (import.meta.client) {
            if (formState.remember) {
                // 儲存帳號密碼
                localStorage.setItem("remembered_login_id", formState.login_id);
                localStorage.setItem("remembered_password", formState.password);
            } else {
                // 清除儲存的帳號密碼
                localStorage.removeItem("remembered_login_id");
                localStorage.removeItem("remembered_password");
            }
        }

        toast.add({
            title: "Login successful",
            description: "Welcome back!",
            color: "success",
        });
        await router.push("/");
    } else {
        error.value = result.message;
    }

    isLoading.value = false;
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
                    登入
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
                    <UFormField label="帳號" name="login_id" required>
                        <UInput
                            v-model="formState.login_id"
                            type="text"
                            placeholder="請輸入您的帳號"
                            icon="i-heroicons-user"
                            size="lg"
                            :disabled="isLoading"
                            class="w-full"
                        />
                    </UFormField>

                    <UFormField label="密碼" name="password" required>
                        <UInput
                            v-model="formState.password"
                            placeholder="請輸入您的密碼"
                            icon="i-heroicons-lock-closed"
                            size="lg"
                            :disabled="isLoading"
                            class="w-full"
                            :type="isShowPassword ? 'text' : 'password'"
                            :ui="{ trailing: 'pe-1' }"
                        >
                            <template #trailing>
                                <UButton
                                    color="neutral"
                                    variant="link"
                                    size="sm"
                                    :icon="
                                        isShowPassword
                                            ? 'i-lucide-eye-off'
                                            : 'i-lucide-eye'
                                    "
                                    :aria-label="
                                        isShowPassword ? 'Hide password' : 'Show password'
                                    "
                                    :aria-pressed="isShowPassword"
                                    aria-controls="password"
                                    @click="isShowPassword = !isShowPassword"
                                />
                            </template>
                        </UInput>
                    </UFormField>

                    <div class="flex items-center">
                        <UCheckbox
                            v-model="formState.remember"
                            label="記住我"
                        />
                    </div>

                    <UButton
                        type="submit"
                        block
                        size="lg"
                        :loading="isLoading"
                        :disabled="!formState.login_id || !formState.password"
                    >
                        登入
                    </UButton>

                    <div v-if="error" class="mt-4">
                        <UAlert
                            icon="i-heroicons-exclamation-triangle"
                            color="error"
                            variant="soft"
                            :title="error"
                        />
                    </div>
                </UForm>
            </UCard>
        </div>
    </div>
</template>
