# 權限系統使用範例

本文檔展示如何在實際應用中使用新的 RBAC 權限系統。

## 📚 目錄

1. [在 Vue 元件中使用](#在-vue-元件中使用)
2. [在路由守衛中使用](#在路由守衛中使用)
3. [在 API 中使用](#在-api-中使用)
4. [常見使用場景](#常見使用場景)

## 在 Vue 元件中使用

### 1. 基本權限檢查

```vue
<script setup lang="ts">
const permission = usePermission()
</script>

<template>
  <div>
    <!-- 檢查單一權限 -->
    <UButton 
      v-if="permission.hasPermission('product.create')"
      @click="createProduct"
    >
      新增產品
    </UButton>

    <!-- 檢查多個權限 (任一) -->
    <div v-if="permission.hasAnyPermission(['product.view', 'product.edit'])">
      產品管理區塊
    </div>

    <!-- 檢查多個權限 (全部) -->
    <UButton
      v-if="permission.hasAllPermissions(['finance.view', 'finance.edit'])"
      @click="editFinance"
    >
      編輯財務
    </UButton>
  </div>
</template>
```

### 2. 使用 PermissionGuard 元件

```vue
<template>
  <div>
    <!-- 基本使用 -->
    <PermissionGuard permission="product.view">
      <UCard>
        <h2>產品列表</h2>
        <!-- 產品內容 -->
      </UCard>
    </PermissionGuard>

    <!-- 多個權限 (任一) -->
    <PermissionGuard :permissions="['product.view', 'product.edit']">
      <UCard>產品管理區塊</UCard>
    </PermissionGuard>

    <!-- 多個權限 (全部必須有) -->
    <PermissionGuard 
      :permissions="['finance.view', 'finance.edit']" 
      require-all
    >
      <UCard>財務編輯區塊</UCard>
    </PermissionGuard>

    <!-- 角色檢查 -->
    <PermissionGuard role="super_admin">
      <UCard>
        <h2>系統管理</h2>
        <!-- 只有超級管理員能看到 -->
      </UCard>
    </PermissionGuard>

    <!-- 顯示無權限訊息 -->
    <PermissionGuard permission="admin.access" fallback>
      <UCard>管理員專用內容</UCard>
      
      <template #fallback>
        <UAlert
          title="需要管理員權限"
          description="請聯絡管理員取得存取權限"
          color="amber"
        />
      </template>
    </PermissionGuard>
  </div>
</template>
```

### 3. 區域權限檢查

```vue
<script setup lang="ts">
const permission = usePermission()

// 檢查使用者可訪問的區域
const accessibleRegions = computed(() => {
  return permission.getAccessibleRegions('product')
})

// 檢查特定區域權限
const canManageSGProducts = computed(() => {
  return permission.hasRegionPermission('product', 'sg', 'manage')
})
</script>

<template>
  <div>
    <!-- 區域選擇器 - 只顯示有權限的區域 -->
    <USelectMenu 
      v-model="selectedRegion"
      :options="regionOptions.filter(r => accessibleRegions.includes(r.value))"
    />

    <!-- 條件顯示按鈕 -->
    <UButton
      v-if="permission.hasRegionPermission('product', 'sg', 'edit')"
      @click="editSGProduct"
    >
      編輯新加坡產品
    </UButton>

    <!-- 多區域顯示 -->
    <div class="grid grid-cols-3 gap-4">
      <PermissionGuard permission="product.tw.manage">
        <UCard>
          <h3>台灣產品</h3>
        </UCard>
      </PermissionGuard>

      <PermissionGuard permission="product.sg.manage">
        <UCard>
          <h3>新加坡產品</h3>
        </UCard>
      </PermissionGuard>

      <PermissionGuard permission="product.mm.manage">
        <UCard>
          <h3>緬甸產品</h3>
        </UCard>
      </PermissionGuard>
    </div>
  </div>
</template>
```

### 4. 模組權限檢查

```vue
<script setup lang="ts">
const permission = usePermission()

// 檢查是否有模組的任何權限
const hasFinanceAccess = computed(() => {
  return permission.hasAnyModulePermission('finance')
})

// 取得使用者在特定模組的所有權限
const financePermissions = computed(() => {
  return permission.getModulePermissions('finance')
})

// 檢查特定模組動作權限
const canEditFinance = computed(() => {
  return permission.hasModulePermission('finance', 'edit', 's2t')
})
</script>

<template>
  <div>
    <!-- 只在有財務權限時顯示整個區塊 -->
    <UCard v-if="hasFinanceAccess">
      <h2>財務管理</h2>
      
      <!-- 檢查特定動作權限 -->
      <UButton
        v-if="permission.hasModulePermission('finance', 'view')"
        @click="viewFinance"
      >
        查看財務
      </UButton>

      <UButton
        v-if="permission.hasModulePermission('finance', 'edit', 's2t')"
        @click="editFinanceS2T"
      >
        編輯新加坡到台灣財務
      </UButton>

      <!-- 顯示使用者的權限列表 -->
      <div class="mt-4">
        <p class="text-sm text-gray-500">您的財務權限：</p>
        <ul>
          <li v-for="perm in financePermissions" :key="perm">
            {{ perm }}
          </li>
        </ul>
      </div>
    </UCard>
  </div>
</template>
```

### 5. 完整頁面範例 - 產品管理

```vue
<script setup lang="ts">
import type { User } from '~/types'

definePageMeta({
  middleware: ['auth'],
})

const permission = usePermission()
const toast = useToast()

// 只有有權限的使用者才能進入此頁面
onMounted(() => {
  if (!permission.hasAnyModulePermission('product')) {
    toast.add({
      title: '沒有權限',
      description: '您沒有權限訪問產品管理',
      color: 'red',
    })
    navigateTo('/')
  }
})

const products = ref([])
const loading = ref(false)

// 根據權限決定可以查看的區域
const accessibleRegions = computed(() => {
  return permission.getAccessibleRegions('product')
})

// 檢查各種操作權限
const canCreate = computed(() => permission.hasPermission('product.create'))
const canEdit = computed(() => permission.hasPermission('product.edit'))
const canDelete = computed(() => permission.hasPermission('product.delete'))

const loadProducts = async () => {
  loading.value = true
  try {
    // API 呼叫
    const data = await $fetch('/api/products', {
      params: {
        regions: accessibleRegions.value,
      },
    })
    products.value = data
  } finally {
    loading.value = false
  }
}

const createProduct = () => {
  navigateTo('/products/create')
}

const editProduct = (id: number) => {
  navigateTo(`/products/${id}/edit`)
}

const deleteProduct = async (id: number) => {
  if (!canDelete.value) {
    toast.add({
      title: '沒有權限',
      description: '您沒有權限刪除產品',
      color: 'red',
    })
    return
  }

  // 執行刪除...
}

onMounted(() => {
  loadProducts()
})
</script>

<template>
  <UDashboardPanel>
    <template #header>
      <UDashboardNavbar title="產品管理">
        <template #right>
          <!-- 只有有新增權限的使用者才能看到新增按鈕 -->
          <UButton
            v-if="canCreate"
            color="primary"
            @click="createProduct"
          >
            <UIcon name="i-lucide-plus" />
            新增產品
          </UButton>
        </template>
      </UDashboardNavbar>

      <UDashboardToolbar>
        <template #left>
          <div class="text-sm text-gray-500">
            可訪問區域: {{ accessibleRegions.join(', ') }}
          </div>
        </template>
      </UDashboardToolbar>
    </template>

    <template #body>
      <!-- 權限守衛 - 確保有查看權限 -->
      <PermissionGuard permission="product.view" fallback>
        <UTable
          :data="products"
          :loading="loading"
          :columns="[
            { key: 'id', label: 'ID' },
            { key: 'name', label: '名稱' },
            { key: 'region', label: '區域' },
            { key: 'actions', label: '操作' },
          ]"
        >
          <template #actions="{ row }">
            <!-- 編輯按鈕 - 檢查權限 -->
            <UButton
              v-if="canEdit && permission.hasRegionPermission('product', row.region, 'edit')"
              size="xs"
              variant="ghost"
              @click="editProduct(row.id)"
            >
              編輯
            </UButton>

            <!-- 刪除按鈕 - 檢查權限 -->
            <UButton
              v-if="canDelete && permission.hasRegionPermission('product', row.region, 'delete')"
              size="xs"
              variant="ghost"
              color="red"
              @click="deleteProduct(row.id)"
            >
              刪除
            </UButton>
          </template>
        </UTable>

        <template #fallback>
          <UAlert
            title="沒有查看權限"
            description="您沒有權限查看產品列表，請聯絡管理員"
            color="amber"
            icon="i-lucide-shield-alert"
          />
        </template>
      </PermissionGuard>
    </template>
  </UDashboardPanel>
</template>
```

## 在路由守衛中使用

### middleware/permission.ts

```typescript
export default defineNuxtRouteMiddleware((to, from) => {
  const permission = usePermission()
  const toast = useToast()

  // 從路由 meta 取得需要的權限
  const requiredPermissions = to.meta.permissions as string[] | undefined
  const requiredRoles = to.meta.roles as string[] | undefined

  // 檢查權限
  if (requiredPermissions && requiredPermissions.length > 0) {
    const hasPermission = permission.hasAnyPermission(requiredPermissions)
    
    if (!hasPermission) {
      toast.add({
        title: '沒有權限',
        description: '您沒有權限訪問此頁面',
        color: 'red',
      })
      return navigateTo('/')
    }
  }

  // 檢查角色
  if (requiredRoles && requiredRoles.length > 0) {
    const hasRole = permission.hasAnyRole(requiredRoles)
    
    if (!hasRole) {
      toast.add({
        title: '沒有權限',
        description: '您的角色無法訪問此頁面',
        color: 'red',
      })
      return navigateTo('/')
    }
  }
})
```

### 在頁面中使用路由守衛

```vue
<script setup lang="ts">
definePageMeta({
  middleware: ['auth', 'permission'],
  permissions: ['product.view', 'product.edit'], // 需要任一權限
  roles: ['product_manager', 'admin'], // 或需要特定角色
})
</script>
```

## 在 API 中使用

### CodeIgniter 控制器範例

```php
<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class ProductController extends ResourceController
{
    protected $modelName = 'App\Models\ProductModel';
    protected $format = 'json';

    public function __construct()
    {
        helper('jwt');
    }

    /**
     * 檢查權限
     */
    private function checkPermission($permission)
    {
        $user = $this->getCurrentUser();
        
        if (!$user) {
            return $this->failUnauthorized('未授權');
        }

        if (!$this->hasPermission($user, $permission)) {
            return $this->failForbidden('沒有權限');
        }

        return true;
    }

    /**
     * 取得當前使用者
     */
    private function getCurrentUser()
    {
        $token = $this->request->getHeaderLine('Authorization');
        // 解析 JWT token 取得使用者資訊
        return getJWTUser($token);
    }

    /**
     * 檢查使用者是否有權限
     */
    private function hasPermission($user, $permission)
    {
        // 檢查使用者的角色權限
        $userModel = new \App\Models\UserModel();
        $permissions = $userModel->getUserPermissions($user->id);
        
        return in_array($permission, $permissions);
    }

    /**
     * 列表
     */
    public function index()
    {
        $check = $this->checkPermission('product.view');
        if ($check !== true) return $check;

        // 根據使用者權限過濾區域
        $user = $this->getCurrentUser();
        $regions = $this->getUserAccessibleRegions($user, 'product');

        $products = $this->model
            ->whereIn('region', $regions)
            ->findAll();

        return $this->respond([
            'success' => true,
            'data' => $products,
        ]);
    }

    /**
     * 新增
     */
    public function create()
    {
        $check = $this->checkPermission('product.create');
        if ($check !== true) return $check;

        $data = $this->request->getJSON(true);
        
        // 檢查是否有該區域的權限
        $user = $this->getCurrentUser();
        $region = $data['region'] ?? null;
        
        if (!$this->hasRegionPermission($user, 'product', $region, 'create')) {
            return $this->failForbidden('沒有權限在此區域新增產品');
        }

        // 新增產品...
        $id = $this->model->insert($data);

        return $this->respondCreated([
            'success' => true,
            'data' => ['id' => $id],
        ]);
    }

    /**
     * 更新
     */
    public function update($id = null)
    {
        $check = $this->checkPermission('product.edit');
        if ($check !== true) return $check;

        // 取得產品檢查區域權限
        $product = $this->model->find($id);
        if (!$product) {
            return $this->failNotFound('產品不存在');
        }

        $user = $this->getCurrentUser();
        if (!$this->hasRegionPermission($user, 'product', $product['region'], 'edit')) {
            return $this->failForbidden('沒有權限編輯此區域的產品');
        }

        // 更新產品...
        $data = $this->request->getJSON(true);
        $this->model->update($id, $data);

        return $this->respond([
            'success' => true,
            'message' => '更新成功',
        ]);
    }

    /**
     * 刪除
     */
    public function delete($id = null)
    {
        $check = $this->checkPermission('product.delete');
        if ($check !== true) return $check;

        // 檢查區域權限
        $product = $this->model->find($id);
        if (!$product) {
            return $this->failNotFound('產品不存在');
        }

        $user = $this->getCurrentUser();
        if (!$this->hasRegionPermission($user, 'product', $product['region'], 'delete')) {
            return $this->failForbidden('沒有權限刪除此區域的產品');
        }

        $this->model->delete($id);

        return $this->respondDeleted([
            'success' => true,
            'message' => '刪除成功',
        ]);
    }

    /**
     * 取得使用者可訪問的區域
     */
    private function getUserAccessibleRegions($user, $module)
    {
        $userModel = new \App\Models\UserModel();
        $permissions = $userModel->getUserPermissions($user->id);
        
        $regions = [];
        foreach (['tw', 'sg', 'mm'] as $region) {
            foreach ($permissions as $perm) {
                if (strpos($perm, "{$module}.{$region}.") === 0) {
                    $regions[] = $region;
                    break;
                }
            }
        }
        
        return $regions;
    }

    /**
     * 檢查區域權限
     */
    private function hasRegionPermission($user, $module, $region, $action)
    {
        $userModel = new \App\Models\UserModel();
        $permissions = $userModel->getUserPermissions($user->id);
        
        $requiredPermission = "{$module}.{$region}.{$action}";
        $managePermission = "{$module}.{$region}.manage";
        
        return in_array($requiredPermission, $permissions) || 
               in_array($managePermission, $permissions);
    }
}
```

### UserModel 權限方法

```php
<?php

namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';
    protected $allowedFields = ['login_id', 'password', 'name', 'email', 'status'];

    /**
     * 取得使用者的所有權限
     */
    public function getUserPermissions($userId)
    {
        $db = \Config\Database::connect();
        
        // 從角色獲取權限
        $rolePermissions = $db->table('permissions p')
            ->select('p.name')
            ->join('role_permissions rp', 'p.id = rp.permission_id')
            ->join('user_roles ur', 'rp.role_id = ur.role_id')
            ->where('ur.user_id', $userId)
            ->get()
            ->getResultArray();

        // 直接授予的權限
        $userPermissions = $db->table('permissions p')
            ->select('p.name, up.is_granted')
            ->join('user_permissions up', 'p.id = up.permission_id')
            ->where('up.user_id', $userId)
            ->get()
            ->getResultArray();

        $permissions = [];
        
        // 合併角色權限
        foreach ($rolePermissions as $perm) {
            $permissions[$perm['name']] = true;
        }
        
        // 套用直接權限（可以覆蓋角色權限）
        foreach ($userPermissions as $perm) {
            $permissions[$perm['name']] = (bool)$perm['is_granted'];
        }
        
        // 返回被授予的權限列表
        return array_keys(array_filter($permissions));
    }

    /**
     * 取得使用者的角色
     */
    public function getUserRoles($userId)
    {
        $db = \Config\Database::connect();
        
        return $db->table('roles r')
            ->select('r.*')
            ->join('user_roles ur', 'r.id = ur.role_id')
            ->where('ur.user_id', $userId)
            ->get()
            ->getResultArray();
    }

    /**
     * 取得使用者完整資料（含角色和權限）
     */
    public function getUserWithPermissions($userId)
    {
        $user = $this->find($userId);
        
        if (!$user) {
            return null;
        }
        
        $user['roles'] = $this->getUserRoles($userId);
        $user['permissions'] = $this->getUserPermissions($userId);
        
        return $user;
    }
}
```

## 常見使用場景

### 1. 財務管理頁面 - 根據路線顯示不同內容

```vue
<template>
  <div>
    <UTabs :items="availableTabs">
      <!-- 新加坡到台灣 -->
      <template #s2t>
        <PermissionGuard permission="finance.s2t.view">
          <FinanceS2TList />
          
          <UButton
            v-if="permission.hasPermission('finance.s2t.print')"
            @click="printS2T"
          >
            列印
          </UButton>
        </PermissionGuard>
      </template>

      <!-- 新加坡到緬甸 -->
      <template #s2y>
        <PermissionGuard permission="finance.s2y.view">
          <FinanceS2YList />
        </PermissionGuard>
      </template>

      <!-- 其他路線... -->
    </UTabs>
  </div>
</template>

<script setup lang="ts">
const permission = usePermission()

// 根據權限動態生成可用的 tabs
const availableTabs = computed(() => {
  const tabs = []
  
  if (permission.hasPermission('finance.s2t.view')) {
    tabs.push({ key: 's2t', label: '新加坡到台灣' })
  }
  
  if (permission.hasPermission('finance.s2y.view')) {
    tabs.push({ key: 's2y', label: '新加坡到緬甸' })
  }
  
  if (permission.hasPermission('finance.t2s.view')) {
    tabs.push({ key: 't2s', label: '台灣到新加坡' })
  }
  
  return tabs
})
</script>
```

### 2. 系統設定 - 只顯示有權限的設定項目

```vue
<template>
  <div class="grid grid-cols-2 gap-4">
    <PermissionGuard permission="finance.setting.manage">
      <UCard>
        <h3>財務設定</h3>
        <NuxtLink to="/settings/finance">
          <UButton>進入設定</UButton>
        </NuxtLink>
      </UCard>
    </PermissionGuard>

    <PermissionGuard permission="exchange.setting.manage">
      <UCard>
        <h3>匯率設定</h3>
        <NuxtLink to="/settings/exchange">
          <UButton>進入設定</UButton>
        </NuxtLink>
      </UCard>
    </PermissionGuard>

    <PermissionGuard permission="deliver.setting.manage">
      <UCard>
        <h3>出貨設定</h3>
        <NuxtLink to="/settings/deliver">
          <UButton>進入設定</UButton>
        </NuxtLink>
      </UCard>
    </PermissionGuard>

    <PermissionGuard role="super_admin">
      <UCard>
        <h3>系統管理</h3>
        <NuxtLink to="/settings/system">
          <UButton>進入設定</UButton>
        </NuxtLink>
      </UCard>
    </PermissionGuard>
  </div>
</template>
```

### 3. 側邊選單 - 根據權限動態生成

```typescript
// composables/useMenu.ts
export const useMenu = () => {
  const permission = usePermission()

  const menuItems = computed(() => {
    const items = []

    // 產品管理
    if (permission.hasAnyModulePermission('product')) {
      items.push({
        label: '產品管理',
        icon: 'i-lucide-package',
        to: '/products',
      })
    }

    // 會員管理
    if (permission.hasAnyModulePermission('member')) {
      items.push({
        label: '會員管理',
        icon: 'i-lucide-users',
        to: '/members',
      })
    }

    // 財務管理
    if (permission.hasAnyModulePermission('finance')) {
      const financeChildren = []
      
      if (permission.hasPermission('finance.view')) {
        financeChildren.push({
          label: '財務總覽',
          to: '/finance',
        })
      }
      
      if (permission.hasPermission('finance.s2t.view')) {
        financeChildren.push({
          label: '新加坡到台灣',
          to: '/finance/s2t',
        })
      }
      
      items.push({
        label: '財務管理',
        icon: 'i-lucide-banknote',
        children: financeChildren,
      })
    }

    // 系統管理
    if (permission.hasRole('super_admin') || permission.hasPermission('system.manage')) {
      items.push({
        label: '系統管理',
        icon: 'i-lucide-settings',
        to: '/settings',
      })
    }

    return items
  })

  return {
    menuItems,
  }
}
```

## 📝 最佳實踐

1. **優先使用角色**：大部分使用者應該透過角色獲得權限
2. **直接權限作為例外**：只在特殊情況下直接授予/撤銷權限
3. **最小權限原則**：只給予必要的權限
4. **清晰的命名**：權限命名應該清楚表達其用途
5. **記錄變更**：使用 `granted_by` 欄位追蹤權限變更
6. **定期審查**：定期檢查和清理不必要的權限

## ❓ 疑難排解

### Q: 如何檢查目前使用者有哪些權限？

```typescript
const permission = usePermission()
const userPermissions = permission.getUserPermissions()
console.log('使用者權限:', userPermissions)
```

### Q: 如何在開發時快速測試不同權限？

在開發環境可以暫時給自己超級管理員角色，或建立測試用的角色和權限。

### Q: 權限變更後需要重新登入嗎？

是的，權限資訊通常在登入時載入。如果需要即時生效，可以實作權限刷新功能。

