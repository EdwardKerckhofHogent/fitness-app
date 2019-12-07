import { MiddlewareFn } from 'type-graphql'
import { ApolloError } from 'apollo-server-core'
import { verify } from 'jsonwebtoken'
import { MyContext } from '../graphql-types/MyContext'

export const isAuth: MiddlewareFn<MyContext> = async ({ context }, next) => {
  const auth = context.req.headers['authorization']

  if (!auth) throw new ApolloError('Not authenticated.')

  try {
    const token = auth.split(' ')[1]
    const payload = verify(token, process.env.JWT_ACCESS_TOKEN_SECRET!)
    context.payload = payload as any
  } catch (error) {
    console.error(error)
    throw new ApolloError('Not authenticated.')
  }

  return next()
}
