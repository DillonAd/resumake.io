/**
 * @flow
 */

import Koa from 'koa'
import bodyParser from 'koa-bodyparser'
import helmet from 'koa-helmet'
import serve from 'koa-static'
import { join } from 'path'
import router from './routes'
import { errorHandler } from './middleware'

const app = new Koa()

if (app.env === 'development') {
  app.proxy = true
}

app.use(errorHandler())
app.use(helmet())
app.use(bodyParser())

if (process.env.NODE_ENV === 'production') {
  app.use(serve(join(__dirname, '..', 'dist')))
}

app.use(router)

export default app
