import type { Ref } from "vue";

export const users = (open: Ref<boolean>) => ({
    label: "帳號設定",
    to: "/users",
    icon: "i-lucide-users",
    onSelect: () => {
        open.value = false;
    },
});

