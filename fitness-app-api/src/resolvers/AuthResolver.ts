import {
  Resolver,
  Query,
  Mutation,
  Arg,
  Ctx,
  UseMiddleware
} from 'type-graphql'
import { ApolloError } from 'apollo-server-core'
import bcrypt from 'bcryptjs'
import { getConnection } from 'typeorm'

import { User } from '../entity/User'
import { createTokens, sendRefreshToken } from '../utils/createTokens'
import { UserResponse } from '../graphql-types/auth/UserResponse'
import { UserInput } from '../graphql-types/auth/UserInput'
import { MyContext } from '../graphql-types/MyContext'
import { isAuth } from '../middleware/IsAuth'

@Resolver()
export class AuthResolver {
  @Query(_ => String)
  async rootQuery(): Promise<String> {
    return 'Hello!'
  }

  @Query(_ => String)
  @UseMiddleware(isAuth)
  async authQuery(@Ctx() { payload }: MyContext): Promise<String> {
    return `your user id is ${payload!.userId}`
  }

  @Mutation(_ => UserResponse)
  async register(
    @Arg('input') { email, password }: UserInput
  ): Promise<UserResponse> {
    const existingUser = await User.findOne({ where: { email } })

    if (existingUser) throw new ApolloError('Email already in use')

    const hashedPassword = await bcrypt.hash(password, 12)

    const user = await User.create({
      email,
      password: hashedPassword
    }).save()

    return { user }
  }

  @Mutation(_ => UserResponse, { nullable: true })
  async login(
    @Arg('input') { email, password }: UserInput,
    @Ctx() { res }: MyContext
  ): Promise<UserResponse> {
    const user = await User.findOne({ where: { email } })

    if (!user) throw new ApolloError('User not found')

    const valid = await bcrypt.compare(password, user.password)

    if (!valid) throw new ApolloError('Invalid password')

    if (!user.confirmed) throw new ApolloError('User email not confirmed.')

    // Login successful
    const { refreshToken, accessToken } = createTokens(user)

    sendRefreshToken(res, refreshToken)

    return {
      accessToken
    }
  }

  @Mutation(_ => Boolean)
  async revokeRefreshToken(@Arg('userId') id: number): Promise<Boolean> {
    await getConnection()
      .getRepository(User)
      .increment({ id }, 'tokenVersion', 1)

    return true
  }
}
