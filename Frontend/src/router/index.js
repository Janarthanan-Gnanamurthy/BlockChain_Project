import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      component: () => import('../views/AboutView.vue')
    },
    {
      path: '/register-manufacturer',
      name: 'manufactuerer-registration',
      component: () => import('../views/ManufacturerRegistration.vue')
    },
    {
      path: '/register-buyer',
      name: 'buyer-registration',
      component: () => import('../views/BuyerRegistration.vue')
    },
    {
      path: '/register-seller',
      name: 'seller-registration',
      component: () => import('../views/SellerRegistration.vue')
    },
    {
      path: '/create-product',
      name: 'create-product',
      component: () => import('../views/CreateProduct.vue')
    },
    {
      path: '/list-product-for-sale',
      name: 'list-product-for-sale',
      component: () => import('../views/ListProduct.vue')
    },
    {
      path: '/purchase-product',
      name: 'purchase-product',
      component: () => import('../views/PurchaseProduct.vue')
    },    
    {
      path: '/create-shipment',
      name: 'create-shipment',
      component: () => import('../views/CreateShipment.vue')
    },
    {
      path: '/log-environmental-data',
      name: 'log-environment-data',
      component: () => import('../views/LogEnvironmentData.vue')
    },
    {
      path: '/environmental-data-display',
      name: 'environmental-data',
      component: () => import('../views/EnvironmentalDataDisplay.vue')
    },
    {
      path: '/environmental-data-display',
      name: 'environmental-data',
      component: () => import('../views/EnvironmentalDataDisplay.vue')
    },
    {
      path: '/shipment-list',
      name: 'shipment-list',
      component: () => import('../views/ListShipments.vue')
    }
  ]
})

export default router
