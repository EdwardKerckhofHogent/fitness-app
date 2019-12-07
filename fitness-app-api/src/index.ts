import 'reflect-metadata'
import dotenv from 'dotenv'
import { ApolloServer } from 'apollo-server-express'
import express, { Application, Request, Response } from 'express'
import cors from 'cors'
import { createDatabseConn } from './utils/createDatabaseConn'

import { createSchema } from './utils/createSchema'

dotenv.config({ path: '.env' })

const PORT = process.env.PORT

const main = async () => {
  // Initialize express
  const app: Application = express()

  // Read settings from ormconfig
  await createDatabseConn()
  //const conn = await createConnection()
  //await conn.runMigrations()

  // Create apollo schema and initialize apolloServer
  const schema = await createSchema()
  const apolloServer = new ApolloServer({
    schema,
    context: ({ req, res }: any) => ({ req, res })
  })

  // Body parser
  app.use(express.json())

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

  app.listen(PORT, () => {
    console.log(
      `🚀 Server ready at http://localhost:${PORT}${apolloServer.graphqlPath}`
    )
  })

  apolloServer.applyMiddleware({ app, cors: false })
}

main()
