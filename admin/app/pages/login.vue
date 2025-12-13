<script setup lang="ts">
definePageMeta({
    layout: false,
    middleware: [],
});

const router = useRouter();
const { login, register } = useAuth();
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

// 註冊表單
const showRegisterModal = ref(false);
const registerState = reactive({
    login_id: "",
    email: "",
    full_name: "",
    password: "",
    password_confirm: "",
});

const isRegistering = ref(false);
const registerError = ref("");

const isRegisterFormValid = computed(() => {
    return (
        registerState.login_id &&
        registerState.email &&
        registerState.password &&
        registerState.password.length >= 8 &&
        registerState.password === registerState.password_confirm
    );
});

const handleRegister = async () => {
    if (!isRegisterFormValid.value) {
        registerError.value = "Please check all fields are correctly filled";
        return;
    }

    isRegistering.value = true;
    registerError.value = "";

    const result = await register({
        login_id: registerState.login_id,
        email: registerState.email,
        full_name: registerState.full_name,
        password: registerState.password,
    });

    if (result.success) {
        toast.add({
            title: "Register successful",
            description: "You have successfully registered and logged in!",
            color: "success",
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
                            忘記密碼?
                        </UButton>
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

            <div class="text-center">
                <p class="text-sm text-gray-600 dark:text-gray-400">
                    還沒有帳號嗎?

                    <!-- 註冊模態框 -->
                    <UModal
                        :ui="{ content: 'sm:max-w-md' }"
                        v-model:open="showRegisterModal"
                    >
                        <UButton
                            variant="link"
                            color="primary"
                            size="sm"
                            :padded="false"
                        >
                            註冊
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
                                        label="帳號"
                                        name="username"
                                        required
                                    >
                                        <UInput
                                            v-model="registerState.username"
                                            type="text"
                                                placeholder="請輸入您的帳號"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField
                                        label="電子信箱"
                                        name="email"
                                        required
                                    >
                                        <UInput
                                            v-model="registerState.email"
                                            type="email"
                                            placeholder="請輸入您的電子信箱"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <UFormField
                                        label="姓名"
                                        name="full_name"
                                    >
                                        <UInput
                                            v-model="registerState.full_name"
                                            type="text"
                                            placeholder="請輸入您的姓名"
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
                                            placeholder="請輸入您的密碼"
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
                                            placeholder="請再次輸入您的密碼"
                                            :disabled="isRegistering"
                                        />
                                    </UFormField>

                                    <div v-if="registerError" class="mt-4">
                                        <UAlert
                                            icon="i-heroicons-exclamation-triangle"
                                            color="error"
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
