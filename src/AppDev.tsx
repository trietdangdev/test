import CodePush from 'react-native-code-push'
/** navigators */
import './i18n/i18n'
import App from './App'

const codePushOptions = {checkFrequency: CodePush.CheckFrequency.MANUAL}

const AppDev = CodePush(codePushOptions)(App)

export default AppDev
