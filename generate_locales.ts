/* eslint-disable @typescript-eslint/no-unsafe-argument */
/* eslint-disable @typescript-eslint/no-floating-promises */
/* eslint-disable no-console */
/* eslint-disable no-useless-concat */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/return-await */
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck
// eslint-disable-next-line @typescript-eslint/no-var-requires
const axios = require('axios')
// eslint-disable-next-line @typescript-eslint/no-var-requires
const fs = require('fs')

const output = `${process.cwd()}/` + 'src/i18n'
const instanceWhitelist = axios.create({
  baseURL:
    'https://script.google.com/macros/s/AKfycbx7lY--rOP4TYtAKfUVetJkbuctwbVx2lQtVu5y4cBYJ0xybjdOOsc7z3ojsj_x6Tg/exec',
  timeout: 1000000,
  headers: {},
})

const getUserWhitelist = async () => await instanceWhitelist.get()

const handlerLocales = async () => {
  const response = await getUserWhitelist()
  if (response) {
    const {data} = response || {}
    // Generate locale folder
    Object.keys(data).forEach(key => {
      const dir = `${output}/${key}`
      if (!fs.existsSync(dir) && !dir?.includes('Link')) {
        fs.mkdirSync(dir)
      }
      if (!dir?.includes('Link')) {
        fs.writeFile(
          `${dir}/common.json`,
          JSON.stringify(data[key], null, 2),
          err => {
            if (err) {
              console.error(err)
            }
          }
        )
      }
    })
  }
}

// all in one
handlerLocales()
