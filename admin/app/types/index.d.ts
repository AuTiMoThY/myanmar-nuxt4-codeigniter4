import type { AvatarProps } from "@nuxt/ui";

// ===== 使用者相關類型 =====
export interface User {
  id: number
  login_id: string
  name: string
  email?: string
  pic?: string
  profile?: string
  status: 'active' | 'inactive' | 'expired'
  expiration_date?: string | null
  created_at: string
  updated_at: string
  last_login_at?: string | null
  avatar?: AvatarProps
  
  // 關聯資料
  roles?: Role[]
  permissions?: Permission[]
  notes?: UserNote[]
}

// ===== 角色相關類型 =====
export interface Role {
  id: number
  name: string
  display_name: string
  description?: string
  is_system: boolean
  created_at: string
  updated_at: string
  
  // 關聯資料
  permissions?: Permission[]
  user_count?: number
}

export interface RoleWithPermissions extends Role {
  permissions: Permission[]
}

// ===== 權限相關類型 =====
export interface Permission {
  id: number
  name: string // 如：product.view, finance.s2t.print
  display_name: string
  description?: string
  module: string // 如：product, finance, member
  category?: string // 如：tw, sg, mm, s2t
  action: string // 如：view, create, edit, delete, manage
  created_at: string
  updated_at: string
}

export interface PermissionGroup {
  module: string
  module_name: string
  permissions: Permission[]
  categories?: {
    [key: string]: Permission[]
  }
}

// ===== 使用者備註 =====
export interface UserNote {
  id: number
  user_id: number
  note_type: 'finance' | 'deliver' | 'purchase'
  content: string
  updated_at: string
}

// ===== 使用者-角色關聯 =====
export interface UserRole {
  id: number
  user_id: number
  role_id: number
  granted_at: string
  granted_by?: number
  
  // 關聯資料
  role?: Role
}

// ===== 使用者-權限關聯（直接權限）=====
export interface UserPermission {
  id: number
  user_id: number
  permission_id: number
  is_granted: boolean // true=授予, false=撤銷
  granted_at: string
  granted_by?: number
  
  // 關聯資料
  permission?: Permission
}

// ===== API 回應類型 =====
export interface ApiResponse<T = any> {
  success: boolean
  data?: T
  message?: string
  error?: string
}

export interface PaginatedResponse<T> {
  data: T[]
  total: number
  page: number
  per_page: number
  last_page: number
}

// ===== 權限檢查相關 =====
export interface PermissionCheck {
  hasPermission: (permission: string | string[]) => boolean
  hasRole: (role: string | string[]) => boolean
  hasAnyPermission: (permissions: string[]) => boolean
  hasAllPermissions: (permissions: string[]) => boolean
  hasAnyRole: (roles: string[]) => boolean
  hasAllRoles: (roles: string[]) => boolean
}

// ===== 表單類型 =====
export interface UserFormData {
  login_id: string
  password?: string
  name: string
  email?: string
  pic?: string
  profile?: string
  status: 'active' | 'inactive' | 'expired'
  expiration_date?: string | null
  role_ids?: number[]
  permission_ids?: number[]
}

export interface RoleFormData {
  name: string
  display_name: string
  description?: string
  permission_ids: number[]
}

// ===== 舊系統遷移用 =====
export interface LegacyUser {
  sysloginID: number
  loginID: string
  password: string
  name: string
  pic?: string
  profile?: string
  time?: string
  create_time?: string
  update_time?: string
  expiration_chk: number
  expiration_date?: string
  note_finance?: string
  note_deliver?: string
  note_purchase?: string
  // 所有 power_* 欄位
  [key: `power_${string}`]: number
}