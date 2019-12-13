import { Resolver, Mutation, UseMiddleware, Ctx, Arg } from 'type-graphql'

import { MyContext } from '../graphql-types/MyContext'
import { isAuth } from '../middleware/IsAuth'
import { RoutineInput } from '../graphql-types/routine/RoutineInput'
import { RoutineResponse } from '../graphql-types/routine/RoutineResponse'
import { Routine } from '../entity/Routine'

@Resolver()
export class RoutineResolver {
  @Mutation(_ => RoutineResponse)
  @UseMiddleware(isAuth)
  async addRoutine(
    @Ctx() { payload }: MyContext,
    @Arg('input') { name }: RoutineInput
  ): Promise<RoutineResponse> {
    if (!payload)
      return {
        errors: [
          {
            path: 'User id',
            message: 'No logged in user'
          }
        ]
      }

    const routine = await Routine.create({
      name,
      userId: payload.userId
    }).save()

    return { routine }
  }
}
