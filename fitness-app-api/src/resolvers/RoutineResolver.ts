import {
  Resolver,
  Mutation,
  UseMiddleware,
  Ctx,
  Arg,
  Query
} from 'type-graphql'

import { MyContext } from '../graphql-types/MyContext'
import { isAuth } from '../middleware/IsAuth'
import { RoutineInput } from '../graphql-types/routine/RoutineInput'
import { RoutineResponse } from '../graphql-types/routine/RoutineResponse'
import { Routine } from '../entity/Routine'
import { Exercise } from '../entity/Exercise'
import { ExerciseSet } from '../entity/ExerciseSet'

@Resolver()
export class RoutineResolver {
  // Add new routine
  @Mutation(_ => RoutineResponse)
  @UseMiddleware(isAuth)
  async addRoutine(
    @Ctx() { payload }: MyContext,
    @Arg('input') { name, exercises }: RoutineInput
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

    const routine = new Routine()
    routine.name = name
    routine.userId = payload.userId
    await routine.save()

    exercises.forEach(async ex => {
      let exercise = new Exercise()
      exercise.name = ex.name
      exercise.routineId = routine.id
      await exercise.save()

      ex.sets.forEach(async set => {
        let exerciseSet = new ExerciseSet()
        exerciseSet.kg = set.kg
        exerciseSet.reps = set.reps
        exerciseSet.exerciseId = exercise.id
        await exerciseSet.save()
      })
    })

    return { routine }
  }

  @Mutation(_ => RoutineResponse)
  async updateRoutine(
    @Arg('input') { id, name, exercises }: RoutineInput
  ): Promise<RoutineResponse> {
    const routine = await Routine.findOne(id, {
      relations: ['exercises', 'exercises.sets']
    })

    if (!routine) {
      return {
        errors: [
          {
            path: 'Routine id',
            message: `No routine with id: ${id} found`
          }
        ]
      }
    }

    if (routine.name !== name) {
      routine.name = name
    }

    let countDiff = Math.abs(exercises.length - routine.exercises.length)
    for (let i = countDiff; i > 0; i--) {
      await Exercise.delete(routine.exercises[i].id)
    }

    exercises.forEach((ex, i) => {
      ex.sets.forEach((set, j) => {
        if (
          set.kg != routine.exercises[i].sets[j].kg ||
          set.reps != routine.exercises[i].sets[j].reps
        ) {
          routine.exercises[i].sets[j].kg = set.kg
          routine.exercises[i].sets[j].reps = set.reps
        }
      })
    })

    await routine.save()

    return { routine }
  }

  @Query(_ => RoutineResponse)
  @UseMiddleware(isAuth)
  async getRoutines(@Ctx() { payload }: MyContext): Promise<RoutineResponse> {
    if (!payload)
      return {
        errors: [
          {
            path: 'User id',
            message: 'No logged in user'
          }
        ]
      }

    const routines = await Routine.find({
      where: { userId: payload.userId },
      relations: ['exercises', 'exercises.sets']
    })

    return { routines }
  }

  @Query(_ => RoutineResponse)
  async getRoutine(@Arg('input') routineId: number): Promise<RoutineResponse> {
    const routine = await Routine.findOne(routineId, {
      relations: ['exercises', 'exercises.sets']
    })

    if (!routine)
      return {
        errors: [
          {
            path: 'Routine id',
            message: `No routine with id: ${routineId} found`
          }
        ]
      }

    return { routine }
  }

  @Mutation(_ => Boolean)
  @UseMiddleware(isAuth)
  async deleteRoutine(@Arg('input') routineId: number): Promise<Boolean> {
    await Routine.delete(routineId)
    return true
  }
}
