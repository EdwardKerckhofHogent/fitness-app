import { InputType, Field } from 'type-graphql'
import { ExerciseInput } from '../exercise/ExerciseInput'

@InputType()
export class RoutineInput {
  @Field({ nullable: true })
  id?: number

  @Field()
  name: string

  @Field(_ => [ExerciseInput])
  exercises: [ExerciseInput]
}
