import type { Ref } from "vue";

export const products = (open: Ref<boolean>) => ({
    label: "產品管理 PRODUCTS",
    to: "/products",
    icon: "i-lucide-box",
    defaultOpen: true,
    type: "trigger",
    children: [
        {
            label: "產品設定 Product Setting",
            to: "/products",
            exact: true,
            onSelect: () => {
                open.value = false;
            },
        },
        {
            label: "組合商品設定 Combo Price",
            to: "/products",
            onSelect: () => {
                open.value = false;
            },
        },
        {
            label: "庫存輸入 Stock Input",
            to: "/products",
            onSelect: () => {
                open.value = false;
            },
        },
        {
            label: "同步新產品設定 NEW PRODUCT KEYIN",
            to: "/products",
            onSelect: () => {
                open.value = false;
            },
        },
    ],
});
