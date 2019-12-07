import 'reflect-metadata'
import dotenv from 'dotenv'
import { ApolloServer } from 'apollo-server-express'
import express, { Application, Request, Response } from 'express'
import cors from 'cors'
import cookieParser from 'cookie-parser'
import { verify } from 'jsonwebtoken'

import { createDatabseConn } from './utils/createDatabaseConn'
import { createSchema } from './utils/createSchema'
import { User } from './entity/User'
import { createTokens, sendRefreshToken } from './utils/createTokens'
;(async () => {
  // Load env vars
  dotenv.config({ path: '.env' })

  const PORT = process.env.PORT
  // Initialize express
  const app: Application = express()

  // Read settings from ormconfig
  const conn = await createDatabseConn()
  await conn.runMigrations()

  // Create apollo schema and initialize apolloServer
  const schema = await createSchema()
  const apolloServer = new ApolloServer({
    schema,
    context: ({ req, res }: any) => ({ req, res })
  })

  // Body parser
  app.use(express.json())

  // Cookie parser
  app.use(cookieParser())

  // Cors middleware
  const corsOptions = {
    origin: process.env.FRONTEND_URL,
    credentials: true // <-- REQUIRED backend setting
  }
  app.use(cors(corsOptions))

  app.get('/', (_: Request, res: Response) => {
    res.send(
      `<h2 style="text-align: center">🚀️ Application server running, navigate <a href="http://localhost:${PORT}${apolloServer.graphqlPath}">here</a> for the GraphQL Playground 🚀️</h2>`
    )
  })

  // Refresh access token
  app.post('/refresh-token', async (req: Request, res: Response) => {
    const token = req.cookies.fitnessAppApiJid
    if (!token) {
      return res.send({ success: false, accessToken: '' })
    }

    let payload: any = null
    try {
      payload = verify(token, process.env.JWT_REFRESH_TOKEN_SECRET!)
    } catch (error) {
      console.error(error)
      return res.send({ success: false, accessToken: '' })
    }

    // token is valid and we can send back an accessToken
    const user = await User.findOne({ id: payload.userId })

    if (!user) {
      return res.send({ success: false, accessToken: '' })
    }

    if (user.tokenVersion !== payload.tokenVersion) {
      return res.send({ success: false, accessToken: '' })
    }

    const { accessToken, refreshToken } = createTokens(user)

    sendRefreshToken(res, refreshToken)

    return res.send({ success: true, accessToken })
  })

  app.listen(PORT, () => {
    console.log(
      `🚀 Server ready at http://localhost:${PORT}${apolloServer.graphqlPath}`
    )
  })

  apolloServer.applyMiddleware({ app, cors: false })
})()
