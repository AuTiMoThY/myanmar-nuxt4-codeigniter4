import type { Ref } from "vue";

export const calendar = (open: Ref<boolean>) => ({
    label: "行事曆 CALENDAR",
    icon: "i-lucide-calendar",
    to: "/calendar",
    onSelect: () => {
        open.value = false;
    },
});
