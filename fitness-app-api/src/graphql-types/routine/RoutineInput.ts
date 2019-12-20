import { InputType, Field } from 'type-graphql'
import { ExerciseInput } from '../exercise/ExerciseInput'

@InputType()
export class RoutineInput {
  @Field()
  name: string

  @Field(_ => [ExerciseInput])
  exercises: [ExerciseInput]
}
