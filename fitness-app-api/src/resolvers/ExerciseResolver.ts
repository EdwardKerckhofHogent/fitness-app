import { Resolver, UseMiddleware, Mutation, Ctx, Arg } from 'type-graphql'

import { ExerciseResponse } from '../graphql-types/exercise/ExerciseResponse'
import { isAuth } from '../middleware/IsAuth'
import { ExerciseInput } from '../graphql-types/exercise/ExerciseInput'
import { MyContext } from '../graphql-types/MyContext'
import { Exercise } from '../entity/Exercise'

@Resolver()
export class ExerciseResolver {
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

    const exercise = await Exercise.create({
      name,
      routineId
    }).save()

    return { exercise }
  }
}
