import { Resolver, UseMiddleware, Mutation, Ctx, Arg } from 'type-graphql'

import { SetResponse } from '../graphql-types/set/SetResponse'
import { SetInput } from '../graphql-types/set/SetInput'
import { isAuth } from '../middleware/IsAuth'
import { MyContext } from '../graphql-types/MyContext'
import { ExerciseSet } from '../entity/ExerciseSet'
import { Exercise } from '../entity/Exercise'

@Resolver()
export class SetResolver {
  // Add new set
  @Mutation(_ => SetResponse)
  @UseMiddleware(isAuth)
  async addSet(
    @Ctx() { payload }: MyContext,
    @Arg('input') { kg, reps, exerciseId }: SetInput
  ) {
    if (!payload)
      return {
        errors: [
          {
            path: 'User id',
            message: 'No logged in user'
          }
        ]
      }

    const exercise = await Exercise.findOne(exerciseId)
    if (!exercise)
      return {
        errors: [
          {
            path: 'Exercise id',
            message: `No exercise with id: ${exerciseId} found`
          }
        ]
      }

    const set = await ExerciseSet.create({
      kg,
      reps,
      exerciseId
    }).save()

    return { set }
  }
}
