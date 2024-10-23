// import DynamicConstants from '@constant/constant/dynamic.constants'
import React from 'react'
import AppDev from './AppDev'
import App from './App'
import Config from '@constant/dynamic.constants'

const AppENV: React.FC = () => {
  if (Config.NODE_ENV === 'development') return <AppDev />
  return <App />
}

export default AppENV
