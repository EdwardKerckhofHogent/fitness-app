import { sign } from 'jsonwebtoken'
import { Response } from 'express'
import { User } from '../entity/User'

export const createTokens = (user: User) => {
  const accessToken = sign(
    { userId: user.id },
    process.env.JWT_ACCESS_TOKEN_SECRET!,
    { expiresIn: '15m' }
  )
  const refreshToken = sign(
    { userId: user.id, tokenVersion: user.tokenVersion },
    process.env.JWT_REFRESH_TOKEN_SECRET!,
    { expiresIn: '364d' }
  )

  return { refreshToken, accessToken }
}

export const sendRefreshToken = (res: Response, token: string) => {
  res.cookie('fitnessAppApiJid', token, {
    httpOnly: true
  })
}
