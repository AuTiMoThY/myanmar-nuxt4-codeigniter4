export const useUsers = () => {
    const config = useRuntimeConfig();
    const { token } = useAuth();

    // API 基礎 URL
    const apiBase = config.public.apiBase || "http://localhost:8080/api";

    /**
     * 取得所有使用者列表
     */
    const getUsers = async () => {
        try {
            const response = await $fetch<{
                status: string;
                data: any[];
            }>(`${apiBase}/auth/users`, {
                headers: {
                    Authorization: `Bearer ${token.value}`,
                },
            });

            if (response.status === "success") {
                return {
                    success: true,
                    data: response.data,
                };
            }

            return {
                success: false,
                data: [],
                message: "取得使用者列表失敗",
            };
        } catch (error: any) {
            console.error("取得使用者列表錯誤:", error);
            return {
                success: false,
                data: [],
                message: error.data?.message || "取得使用者列表失敗",
            };
        }
    };

    /**
     * 取得單一使用者
     */
    const getUser = async (id: number | string) => {
        try {
            const response = await $fetch<{
                status: string;
                data: any;
            }>(`${apiBase}/auth/users/${id}`, {
                headers: {
                    Authorization: `Bearer ${token.value}`,
                },
            });

            if (response.status === "success") {
                return { success: true, data: response.data };
            }

            return { success: false, message: "取得使用者失敗" };
        } catch (error: any) {
            console.error("取得使用者錯誤:", error);
            return {
                success: false,
                message: error.data?.message || "取得使用者失敗",
            };
        }
    };

    /**
     * 新增使用者（使用註冊 API）
     */
    const createUser = async (payload: {
        login_id: string;
        email: string;
        password: string;
        name?: string;
    }) => {
        try {
            const response = await $fetch<{
                status: string;
                message?: string;
                data?: any;
            }>(`${apiBase}/auth/register`, {
                method: "POST",
                body: {
                    login_id: payload.login_id,
                    email: payload.email,
                    password: payload.password,
                    // 嘗試同送 name 與 full_name 以兼容後端
                    name: payload.name,
                    full_name: payload.name,
                },
            });

            if (response.status === "success") {
                return { success: true, data: response.data };
            }

            return {
                success: false,
                message: response.message || "新增使用者失敗",
            };
        } catch (error: any) {
            console.error("新增使用者錯誤:", error);
            // CodeIgniter 可能回傳多欄位錯誤
            const message =
                typeof error.data === "object"
                    ? Object.values(error.data).join("、")
                    : error.data?.message || "新增使用者失敗";
            return { success: false, message };
        }
    };

    /**
     * 更新使用者
     */
    const updateUser = async (
        id: number | string,
        payload: Partial<{
            login_id: string;
            email: string;
            password: string;
            name: string;
            status: "active" | "inactive" | "suspended";
        }>
    ) => {
        try {
            const response = await $fetch<{
                status: string;
                message?: string;
                data?: any;
            }>(`${apiBase}/auth/users/${id}`, {
                method: "PUT",
                body: payload,
                headers: {
                    Authorization: `Bearer ${token.value}`,
                },
            });

            if (response.status === "success") {
                return { success: true, data: response.data };
            }

            return {
                success: false,
                message: response.message || "更新使用者失敗",
            };
        } catch (error: any) {
            console.error("更新使用者錯誤:", error);
            const message =
                typeof error.data === "object"
                    ? Object.values(error.data).join("、")
                    : error.data?.message || "更新使用者失敗";
            return { success: false, message };
        }
    };

    return {
        getUsers,
        getUser,
        createUser,
        updateUser,
    };
};

