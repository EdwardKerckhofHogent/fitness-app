import {
  Resolver,
  Query,
  Mutation,
  Arg,
  Ctx,
  UseMiddleware
} from 'type-graphql'
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
    @Arg('input') { email, password, repeatPassword }: UserInput
  ): Promise<UserResponse> {
    const existingUser = await User.findOne({ where: { email } })

    if (existingUser) {
      return {
        errors: [
          {
            path: 'email',
            message: 'Email wordt al gebruikt'
          }
        ]
      }
    }

    if (password !== repeatPassword) {
      return {
        errors: [
          {
            path: 'repeatPassword',
            message: 'Wachtwoorden zijn niet gelijk aan elkaar'
          }
        ]
      }
    }

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

    if (!user) {
      return {
        errors: [
          {
            path: 'email',
            message: 'Gebruiker niet gevonden'
          }
        ]
      }
    }

    const valid = await bcrypt.compare(password, user.password)

    if (!valid) {
      return {
        errors: [
          {
            path: 'password',
            message: 'Ongeldig wachtwoord'
          }
        ]
      }
    }

    if (!user.confirmed) {
      return {
        errors: [
          {
            path: 'confirmed',
            message: 'Account nog niet geconfirmeerd'
          }
        ]
      }
    }

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
