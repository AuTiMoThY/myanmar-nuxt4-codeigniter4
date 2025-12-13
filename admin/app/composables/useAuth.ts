export const useAuth = () => {
    const config = useRuntimeConfig();
    const router = useRouter();

    // API 基礎 URL
    const apiBase = config.public.apiBase || "http://localhost:8080/api";

    // 狀態管理
    const user = useState<any>("user", () => {
        if (import.meta.client) {
            const storedUser = localStorage.getItem("user");
            return storedUser ? JSON.parse(storedUser) : null;
        }
        return null;
    });
    const token = useState<string | null>("token", () => {
        if (import.meta.client) {
            return localStorage.getItem("auth_token");
        }
        return null;
    });
    const isAuthenticated = computed(() => !!token.value && !!user.value);

    /**
     * 登入
     */
    const login = async (login_id: string, password: string) => {
        try {
            const response = await $fetch<{
                status: string;
                message: string;
                data: {
                    user: any;
                    token: string;
                };
            }>(`${apiBase}/auth/login`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                credentials: "include",
                body: {
                    login_id,
                    password,
                },
            });

            if (response.status === "success") {
                token.value = response.data.token;
                user.value = response.data.user;

                // 儲存到 localStorage
                if (import.meta.client) {
                    localStorage.setItem("auth_token", response.data.token);
                    localStorage.setItem(
                        "user",
                        JSON.stringify(response.data.user)
                    );
                }

                return {
                    success: true,
                    message: response.message,
                };
            }

            return {
                success: false,
                message: response.message || "登入失敗",
            };
        } catch (error: any) {
            console.error("登入錯誤:", error);
            return {
                success: false,
                message: error.data?.message || "登入失敗，請稍後再試",
            };
        }
    };

    /**
     * 登出
     */
    const logout = async () => {
        try {
            if (token.value) {
                await $fetch(`${apiBase}/auth/logout`, {
                    method: "POST",
                    headers: {
                        Authorization: `Bearer ${token.value}`,
                    },
                });
            }
        } catch (error) {
            console.error("登出錯誤:", error);
        } finally {
            // 清除狀態
            token.value = null;
            user.value = null;

            // 清除 localStorage
            if (import.meta.client) {
                localStorage.removeItem("auth_token");
                localStorage.removeItem("user");
            }

            // 導向登入頁
            await router.push("/login");
        }
    };

    /**
     * 取得當前使用者資料
     */
    const fetchUser = async () => {
        if (!token.value) {
            return false;
        }

        try {
            const response = await $fetch<{
                status: string;
                data: any;
            }>(`${apiBase}/auth/me`, {
                headers: {
                    Authorization: `Bearer ${token.value}`,
                },
            });

            if (response.status === "success") {
                user.value = response.data;

                // 更新 localStorage
                if (import.meta.client) {
                    localStorage.setItem("user", JSON.stringify(response.data));
                }

                console.log("user", user.value);

                return true;
            }

            return false;
        } catch (error) {
            console.error("取得使用者資料錯誤:", error);
            // Token 無效，清除認證資訊
            await logout();
            return false;
        }
    };

    /**
     * 註冊
     */
    const register = async (data: {
        login_id: string;
        email: string;
        password: string;
        full_name?: string;
    }) => {
        try {
            const response = await $fetch<{
                status: string;
                message: string;
                data: {
                    user: any;
                    token: string;
                };
            }>(`${apiBase}/auth/register`, {
                method: "POST",
                body: data,
            });

            if (response.status === "success") {
                token.value = response.data.token;
                user.value = response.data.user;

                // 儲存到 localStorage
                if (import.meta.client) {
                    localStorage.setItem("auth_token", response.data.token);
                    localStorage.setItem(
                        "user",
                        JSON.stringify(response.data.user)
                    );
                }

                return {
                    success: true,
                    message: response.message,
                };
            }

            return {
                success: false,
                message: response.message || "註冊失敗",
            };
        } catch (error: any) {
            console.error("註冊錯誤:", error);
            return {
                success: false,
                message: error.data?.message || "註冊失敗，請稍後再試",
            };
        }
    };

    /**
     * 初始化認證狀態
     */
    const initAuth = async () => {
        // 如果已經有 token 和 user（從 useState 初始化讀取），則驗證 token 是否仍然有效
        if (token.value && user.value) {
            // 驗證 token 是否仍然有效
            await fetchUser();
        }
    };

    return {
        user: readonly(user),
        token: readonly(token),
        isAuthenticated,
        login,
        logout,
        register,
        fetchUser,
        initAuth,
    };
};
