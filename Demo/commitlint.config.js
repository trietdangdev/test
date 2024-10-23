module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    // Allow emojis in the subject line
    'subject-full-stop': [2, 'never', '.'],
    'subject-case': [0],
    // Customize the type-enum rule to include emoji types
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'perf',
        'refactor',
        'chore',
        'style',
        'test',
        'ci',
      ],
    ],
  },
}
