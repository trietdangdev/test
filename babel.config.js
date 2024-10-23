module.exports = {
  presets: ['module:metro-react-native-babel-preset'],
  plugins: [
    [
      'module-resolver',
      {
        root: ['./src'],
        alias: {
          '@share': ['./src/share'],
          '@modules': ['./src/modules'],
          '@manager': ['./src/manager'],
          '@liberty-ui-kit': ['./DesignSystem'],
          '@liberty-chat-system': ['./ChatSystem'],
          '@constant': ['./src/constant'],
          '@navigation': ['./src/navigation'],
          '@components': ['./src/components'],
          '@assets': ['./src/assets'],
          '@app-types': ['./src/types'],
          '@utils': ['./src/utils'],
          '@i18n': ['./src/i18n'],
          '@app': ['./src'],
          '*': ['./*'],
        },
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
    ],
    ['react-native-worklets-core/plugin'],
    'react-native-reanimated/plugin',
  ],
}
