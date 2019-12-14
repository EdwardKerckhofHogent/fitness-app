import { InputType, Field } from 'type-graphql'

@InputType()
export class ExerciseInput {
  @Field()
  name: string

  @Field()
  routineId: number
}
