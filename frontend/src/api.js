import axios from 'axios'

const BASE = import.meta.env.VITE_API_URL || 'http://localhost:8000'
const api  = axios.create({ baseURL: BASE, timeout: 15000 })

export const predict      = (text) => api.post('/predict', { text })
export const getStats     = ()     => api.get('/stats')
export const getVideos    = ()     => api.get('/stats/video')
export const getModel     = ()     => api.get('/model')
export const getCompar    = ()     => api.get('/model/comparison')
export const getConfusion = ()     => api.get('/model/confusion')
export const getTerdahulu = ()     => api.get('/model/terdahulu')
export const getAgreement = ()     => api.get('/stats/agreement')
