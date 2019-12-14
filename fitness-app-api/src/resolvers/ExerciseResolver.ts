import { Resolver, UseMiddleware, Mutation, Ctx, Arg } from 'type-graphql'

import { ExerciseResponse } from '../graphql-types/exercise/ExerciseResponse'
import { isAuth } from '../middleware/IsAuth'
import { ExerciseInput } from '../graphql-types/exercise/ExerciseInput'
import { MyContext } from '../graphql-types/MyContext'
import { Exercise } from '../entity/Exercise'
import { Routine } from '../entity/Routine'

@Resolver()
export class ExerciseResolver {
  // Add new exercise
  @Mutation(_ => ExerciseResponse)
  @UseMiddleware(isAuth)
  async addExercise(
    @Ctx() { payload }: MyContext,
    @Arg('input') { name, routineId }: ExerciseInput
  ): Promise<ExerciseResponse> {
    if (!payload)
      return {
        errors: [
          {
            path: 'User id',
            message: 'No logged in user'
          }
        ]
      }

    const routine = await Routine.findOne(routineId)
    if (!routine)
      return {
        errors: [
          {
            path: 'Routine id',
            message: `No routine with id: ${routineId} found`
          }
        ]
      }

    const exercise = await Exercise.create({
      name,
      routineId
    }).save()

    return { exercise }
  }
}
